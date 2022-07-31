// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Root {

    constructor() {
    }

    // calculates a^(1/n) to dp decimal places
    // maxIts bounds the number of iterations performed
    function nthRoot(uint _a, uint _n, uint _dp, uint _maxIts) pure public returns(uint) {
        assert (_n > 1);
        if(_a == 0) return 0;
        // The scale factor is a crude way to turn everything into integer calcs.
        // Actually do (a * (10 ^ ((dp + 1) * n))) ^ (1/n)
        // We calculate to one extra dp and round at the end
        uint one = 10 ** (1 + _dp);
        if(_a == 1) return 10 ** _dp;
        uint a0 = one ** _n * _a;

        // Initial guess: 1.0
        uint xNew = one;
        uint x = 0;

        uint iter = 0;
        while (xNew != x && iter < _maxIts) {
            x = xNew;
            uint t0 = x ** (_n - 1);
            if (x * t0 > a0) {
                xNew = x - (x - a0 / t0) / _n;

            } else {
                xNew = x + (a0 / t0 - x) / _n;
            }
            ++iter;
        }

        // Round to nearest in the last dp.
        return (xNew + 5) / 10;
    }

    function splitNum(uint _val) pure public returns(uint, uint) {
        uint prefix = _val;
        uint suffix = 0;
        
        uint j = _val;
        uint len;
        while (j != 0) {
           len++;
           j /= 10;
        }
        if(len > 6){
            suffix = 10 ** (len - 6);
            prefix /= suffix;
        }
        return (prefix, suffix);
    }

    function mainFormula(uint _value1, uint _value2, uint _dp, uint _maxIts) pure public returns(uint) {
        uint result = 0;
        if(_value1 == 0) return result;
        uint one = 10 ** _dp;
        uint firstRes = (625 * one) * (_value1 * one) / 100 + (_value2 * one) * nthRoot(_value2, 4, _dp, _maxIts);
        uint res = 0;
        res = firstRes / (one*one);
        if(res == 0) return result;
        uint pre = 0;
        uint suff = 0;
        (pre, suff) = splitNum(res);
        uint nRes = 0;
        if(suff == 0)
            nRes = nthRoot(res, 5, _dp, _maxIts);
        else
            nRes = nthRoot(pre, 5, _dp, _maxIts) * nthRoot(suff, 5, _dp, _maxIts) / one;
        result = firstRes / nRes - _value2 * one;
        // return (res1, res2, res, nres, result);
        // return (result, nRes);
        return result;
    }
}

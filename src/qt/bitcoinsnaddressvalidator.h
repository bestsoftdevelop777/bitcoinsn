// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOINSN_QT_BITCOINSNADDRESSVALIDATOR_H
#define BITCOINSN_QT_BITCOINSNADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BitcoinSNAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinSNAddressEntryValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

/** BitcoinSN address widget validator, checks for a valid bitcoinsn address.
 */
class BitcoinSNAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinSNAddressCheckValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

#endif // BITCOINSN_QT_BITCOINSNADDRESSVALIDATOR_H

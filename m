Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A02CC130
	for <lists+linux-can@lfdr.de>; Wed,  2 Dec 2020 16:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgLBPqk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Dec 2020 10:46:40 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:9440 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgLBPqk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Dec 2020 10:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606923768;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=czwoKdqK80aa1o3yqCtCJMiX5Zd2/BT+Jlcsj5VfkCA=;
        b=OT7HAl6OquZrAzApx5VppVaX2FcoaJAkJwermjIuQZ2F5SXGQwSC7VzZTUtf4yZ1Oz
        8EtFNZXWYSmcYw5XjFOtNTMgC4BOcHunkX5eNEPBp0HsjRymuUL/2VpDY2A03G5hEmkO
        QKVgAjcwTBkmZKWmzS2R5JDkEg9W6RnzqK2AiXJv9CDxvMYwKvdTPvMJvfZ/fzNNjQ1d
        ZMcv9kseEGotgQu3L4GovGAgGg0qcevtomcf7M1JaZX/lLhkSDCdosCrJgAWkKPHryhV
        ybZqTTpdGHUIje243Jusz6A56n5JzOxv7ti1wIlL57X2YRUh2FNUZ/uT7LZaUmr/3JT7
        enFg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iO89vpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB2FgkCQh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 16:42:46 +0100 (CET)
Subject: Re: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
To:     Thomas Wagner <thomas.wagner@pa-systems.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     "thwa1@web.de" <thwa1@web.de>
References: <AM9PR06MB72834DE8FE187784AE914AB2B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <bf1b3dd2-1a43-0bc7-d1db-f4ad010944ed@hartkopp.net>
 <AM9PR06MB7283F123B4B9B5A781597379B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a01a36d2-725f-6de0-51bb-5a40be8d3e5b@hartkopp.net>
Date:   Wed, 2 Dec 2020 16:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <AM9PR06MB7283F123B4B9B5A781597379B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Thomas,

On 02.12.20 15:58, Thomas Wagner wrote:

>> Btw. I would like to ask about the naming of the flag.
>>
>> CAN_ISOTP_FADDR_TX_ONLY
>> CAN_ISOTP_FUNCADDR_TX
>> CAN_ISOTP_FUNC_ADDR
>> CAN_ISOTP_FUNC_ADDR_TX
>> (?? other ideas ??)
> 
> I guess broadcast CAN_ISOTP_BROADCAST would be a more generic description, implying the 1-to-N nature where listeners might
> establish a 1-to-1 connection as needed. But considering the flag would probably mainly be used with OBD/UDS functional addressing
> CAN_ISOTP_FUNC_ADDR doesn't seem half bad IMO.

'BROADCAST' is a good hint!

I'll start with

#define CAN_ISOTP_SF_BROADCAST 0x800   /* 1-to-N functional addressing */

>> Btw. If you already have established the 8 1-to-1 sockets as described
>> above the ECU can also send PDUs with length >7 bytes as your socket
>> would do the protocol handshake.
> 
> Yes, that's the way I have been working most of the time. Even when sending functional requests to all ECUs, they will respond to those
> 8 1-to-1 sockets and hence I am able to receive responses that are quiet long. E.g. I can send a single functional request to make all
> available ECUs identify with an ID, which is normally longer than 7 byte.

Ah, that completes my picture.

>> Are you currently working on a Linux 5.10-rc kernel with ISO-TP included
>> in the tree - or would you like the testing based on my GitHub isotp repo?
> 
> I would much prefer to work of the GitHub repo if possible, as I don't have a setup for newer kernels with CAN hardware.

Ok. Will send a notification here when the RFC code is ready to test.

Best regards,
Oliver

Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B377A2CBE72
	for <lists+linux-can@lfdr.de>; Wed,  2 Dec 2020 14:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgLBNgG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Dec 2020 08:36:06 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:29907 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgLBNgF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Dec 2020 08:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606915933;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ZePi3w8rp8FS1iSkqEiLy78MnJ32klGkUQa6Uv32eQc=;
        b=CTkLF2Eyub8AxdybikrEl6AfGmWBaDTgVbeRf2TyQTwtSaj84w3HgoevwAf37uPd0e
        l3hy37laKxn/bi93nj2DrvD927qa7Hz/8Jity77CKj/htFVf43JyoXd2bIlmAs+LSpxt
        gT96Ikq64LdfhzfmKFY76cu5jv8nlJm8YN2qTmpDBVmP6SpbQm5oft8gi46Sy3Vfdr+O
        5REfK59mOT9u3K0Qv4satAZgiFIUyfk+SZ+uoFZkcoezlJmpbKUUMghJ8mx17cjbUqLk
        3tzgyZH4fIBha44A77dOz+Cf4mZ5vwDfdz4do2RgckVz+VV9KoUTI78xvmnSVnlBk8Za
        pcIw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iO89vpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB2DWCBqq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 14:32:12 +0100 (CET)
Subject: Re: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
To:     Thomas Wagner <thomas.wagner@pa-systems.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     "thwa1@web.de" <thwa1@web.de>
References: <AM9PR06MB72834DE8FE187784AE914AB2B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <bf1b3dd2-1a43-0bc7-d1db-f4ad010944ed@hartkopp.net>
Date:   Wed, 2 Dec 2020 14:32:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <AM9PR06MB72834DE8FE187784AE914AB2B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Thomas,

thanks for showing up here on the Linux-CAN mailing list!

On 02.12.20 13:28, Thomas Wagner wrote:

> as already discussed with Oliver Hartkopp via Github (https://github.com/hartkopp/can-isotp/issues/36), I suggest a new option/flag to enable ISO-TP sockets with just a TX address, while the RX address is being ignored/discarded. This can be useful for OBD2/UDS usage, where functional requests are used and sent in a 1-to-N scenario, while still having an ISO-TP style PCI.
> 
> Oliver:
>> It would be something like a new flag, e.g. CAN_ISOTP_FADDR_TX_ONLY where only the tp.tx_id is used at bind() time (no registering of a tp.rx_id) and where you only can send PDUs that are max 7 bytes => SF.

Yes. I would be fine with it.

Btw. I would like to ask about the naming of the flag.

CAN_ISOTP_FADDR_TX_ONLY
CAN_ISOTP_FUNCADDR_TX
CAN_ISOTP_FUNC_ADDR
CAN_ISOTP_FUNC_ADDR_TX
(?? other ideas ??)

> In depth Use-Case explanation:
> With OBD2 and UDS requests on CAN, ISO-TP is used as a transport protocol. Requests can be physically addressed by a tester to a specific ECU using the CAN-IDs 0x7E0 to 0x7E7 (11-bit IDs).
> The ECUs respond to the tester using the CAN-IDs 0x7E8 to 0x7EF. A tester can open 8 ISO-TP sockets, using the specific RX and TX addresses, to communicate with each ECU.
> In some cases requests aren't sent physically addressed to a specific ECU, but broadcasted/functionally addressed to all ECUs who might care/can respond. This is done using the special CAN-ID 0x7DF.
> Any ECU that might respond does so, using it's to-tester address (0x7E8 to 0x7EF). This way a 1-to-N broadcast/request can be done, after which multiple 1-to-1 connections can be established to transfer large PDUs.

Btw. If you already have established the 8 1-to-1 sockets as described 
above the ECU can also send PDUs with length >7 bytes as your socket 
would do the protocol handshake.

> In the current ISO-TP/SocketCAN implementation, an additional 9th socket needs to be used for those functional requests. Using an ISO-TP socket as 9th socket forces the user to choose an RX address that is never actually used. Using a RAW CAN socket forces the user to calculate/build a PCI manually and have the socket discard/filter all RX traffic. 

You can simply remove the single default CAN_RAW filter which receives 
all CAN-IDs:

(see in cansend.c code)

setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);


> AFAIK functional requests are always <7B data, so ISO-TP would be fine without a RX address for flow control on the 7DF request socket.

Now I seed what you meant with "<7B" .. "<7 bytes"
:-D

> Any feedback/thoughts on that? :)

I'm currently working on the sja1000 arbitration lost topic but I can 
send a RFC patch for this suggestion afterwards.

Are you currently working on a Linux 5.10-rc kernel with ISO-TP included 
in the tree - or would you like the testing based on my GitHub isotp repo?

Best regards,
Oliver

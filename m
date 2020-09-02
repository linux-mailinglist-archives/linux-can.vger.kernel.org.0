Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F4125A63A
	for <lists+linux-can@lfdr.de>; Wed,  2 Sep 2020 09:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIBHOm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Sep 2020 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgIBHOl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Sep 2020 03:14:41 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Sep 2020 00:14:41 PDT
Received: from mailproxy03.manitu.net (mailproxy03.manitu.net [IPv6:2a00:1828:1000:1108::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012BDC061244
        for <linux-can@vger.kernel.org>; Wed,  2 Sep 2020 00:14:40 -0700 (PDT)
Received: from [IPv6:2001:a61:bb6:801:d448:3c0a:26b6:cbb1] (unknown [IPv6:2001:a61:bb6:801:d448:3c0a:26b6:cbb1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id 3868AD46D77;
        Wed,  2 Sep 2020 09:08:51 +0200 (CEST)
Subject: Re: canfdtest on flexcan loopback
To:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Pankaj Bansal (OSS)" <pankaj.bansal@oss.nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
References: <VI1PR04MB4093944944C574B138371F51F12F0@VI1PR04MB4093.eurprd04.prod.outlook.com>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <54b51f10-0b80-c41f-11d2-e1caa851dd50@grandegger.com>
Date:   Wed, 2 Sep 2020 09:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4093944944C574B138371F51F12F0@VI1PR04MB4093.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

Am 02.09.20 um 05:16 schrieb Pankaj Bansal:
> Hi Marc et al,
> 
> I am running the canfdtest (can-utils-2020.02.04) on flexcan interface running in loopback mode:
> 
> # ip link set can1 up type can bitrate 125000 loopback on
> # canfdtest -v -g can1
> interface = can1, family = 29, type = 3, proto = 1
> Databyte 0 mismatch !
> expected: 0077: [8] 01 02 03 04 05 06 07 08
> received: 0077: [8] 00 01 02 03 04 05 06 07
> Databyte 1 mismatch !
> expected: 0077: [8] 01 02 03 04 05 06 07 08
> received: 0077: [8] 00 01 02 03 04 05 06 07
> Databyte 2 mismatch !
> expected: 0077: [8] 01 02 03 04 05 06 07 08
> received: 0077: [8] 00 01 02 03 04 05 06 07
> Databyte 3 mismatch !
> expected: 0077: [8] 01 02 03 04 05 06 07 08
> received: 0077: [8] 00 01 02 03 04 05 06 07
> Databyte 4 mismatch !
> expected: 0077: [8] 01 02 03 04 05 06 07 08
> received: 0077: [8] 00 01 02 03 04 05 06 07
> Databyte 5 mismatch !
> expected: 0077: [8] 01 02 03 04 05 06 07 08
> received: 0077: [8] 00 01 02 03 04 05 06 07
> Databyte 6 mismatch !
> expected: 0077: [8] 01 02 03 04 05 06 07 08
> received: 0077: [8] 00 01 02 03 04 05 06 07
> Databyte 7 mismatch !
> expected: 0077: [8] 01 02 03 04 05 06 07 08
> received: 0077: [8] 00 01 02 03 04 05 06 07
> 
> Test messages sent and received: 0
> Exiting...
> 
> However when I run cangen, then the order of frames is fine:
> 
> # candump can1 &
> # cangen -n 100 can1
>   can1  4B2   [6]  65 BD 28 6D 49 0A
>   can1  4B2   [6]  65 BD 28 6D 49 0A
>   can1  7FF   [8]  8D 05 E2 50 B0 C0 8D 79
>   can1  7FF   [8]  8D 05 E2 50 B0 C0 8D 79
>   can1  397   [0]
>   can1  397   [0]
>   can1  3A2   [0]
>   can1  3A2   [0]
>   can1  143   [8]  22 A1 C5 56 FF 24 15 3A
>   can1  143   [8]  22 A1 C5 56 FF 24 15 3A
>   can1  036   [8]  6D 5B 6C 6D E8 39 E6 5E
>   can1  036   [8]  6D 5B 6C 6D E8 39 E6 5E
>   can1  393   [0]
>   can1  393   [0]
>   can1  5FC   [6]  42 CC F2 57 AE 22
>   can1  5FC   [6]  42 CC F2 57 AE 22
>   can1  08C   [7]  F8 2C BD 6F 8B 98 53
>   can1  08C   [7]  F8 2C BD 6F 8B 98 53
>   can1  4E1   [5]  3C 59 E1 3D 78
>   can1  4E1   [5]  3C 59 E1 3D 78
>   can1  6D6   [6]  5D AF EF 06 78 EA
>   can1  6D6   [6]  5D AF EF 06 78 EA
>   can1  217   [7]  10 DB EC 26 5A F3 49
>   can1  217   [7]  10 DB EC 26 5A F3 49
>   can1  072   [2]  59 18
>   can1  072   [2]  59 18
>   can1  5BF   [7]  91 BA 17 7F 52 F1 0D
>   can1  5BF   [7]  91 BA 17 7F 52 F1 0D
>   can1  307   [2]  C9 DA
>   can1  307   [2]  C9 DA
>   can1  628   [8]  B2 9B 31 26 B4 46 10 30
>   can1  628   [8]  B2 9B 31 26 B4 46 10 30
>   can1  0B2   [8]  3F DF 63 74 94 6D 33 4B
>   can1  0B2   [8]  3F DF 63 74 94 6D 33 4B
>   can1  330   [8]  0C BE 31 4B 06 FA 5C 78
>   can1  330   [8]  0C BE 31 4B 06 FA 5C 78
>   can1  142   [8]  7E E4 3E 69 59 7B 28 64
>   can1  142   [8]  7E E4 3E 69 59 7B 28 64
>   can1  511   [8]  B3 6E 72 1F 83 6D FF 3A
>   can1  511   [8]  B3 6E 72 1F 83 6D FF 3A
>   can1  3C1   [8]  2C EE 30 5B 80 79 51 13
>   can1  3C1   [8]  2C EE 30 5B 80 79 51 13
>   can1  2D4   [8]  D2 6A 5F 00 DB ED D4 38
>   can1  2D4   [8]  D2 6A 5F 00 DB ED D4 38
>   can1  3F0   [8]  DF 66 77 38 18 A2 1D 4D
>   can1  3F0   [8]  DF 66 77 38 18 A2 1D 4D
> 
> I am using the latest Linux-stable-rc kernel (v5.9-rc2).
> 
> Is this known issue/limitation with canfdtest application ?

canfdtest normally runs on the DUT *and* a the host. The DUT receives
the messages from the host, increments the frame data bytes and then
sends them back to the host. With "loopback" mode, the data bytes are
not incremented and that's what you see above.

Wolfgang

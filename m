Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E9655AA8
	for <lists+linux-can@lfdr.de>; Sat, 24 Dec 2022 16:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiLXP5R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Sat, 24 Dec 2022 10:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiLXP5O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Dec 2022 10:57:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A93DF38
        for <linux-can@vger.kernel.org>; Sat, 24 Dec 2022 07:57:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p96tZ-00083s-G5; Sat, 24 Dec 2022 16:57:09 +0100
Received: from pengutronix.de (unknown [IPv6:2a00:20:7002:bc84:8cc7:7500:b0c5:1f53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A599F146523;
        Sat, 24 Dec 2022 15:57:06 +0000 (UTC)
Date:   Sat, 24 Dec 2022 16:57:05 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: AW: mcp251xfd: Bad message receiption
Message-ID: <20221224155705.l6qx3xu34nmo3ehn@pengutronix.de>
References: <FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <PH7PR11MB6498DA4A162106BD4ACB7551FBE89@PH7PR11MB6498.namprd11.prod.outlook.com>
 <FR0P281MB1966CA0C12ED24574368A36E97E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221222130219.xrfnm54g6lfjozvs@pengutronix.de>
 <FR0P281MB19666A63278AAA9D20B6989297E99@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <FR0P281MB19666A63278AAA9D20B6989297E99@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I've looked at the regmap dump and added the offset in the RX and TX
FIFOs.

tl;dr:

Everything, but the last 2 messages, look consistent The last 2 RX
messages have not been received by the hardware. On the other hand the
hardware has received the correct messages, but they were not received
by the test application.

On 23.12.2022 08:18:17, Stefan Althöfer wrote:
> Loop 4429 2022-12-23T03:07:45 last+4s total:4h299m
> + ./sctestself -b -n 4 -l 999 -t 2 -v cmperr,logmsg -F refilldata,leastdots,allowintloopb,stoponerror -d 8 can1
> CAN selftest can1 .......idx    2 tx:2A5#00 02 6A 8F 6C 81 C3 B0
>          rx:2A5#00 00 85 9A EF 54 34 5D
> idx    3 tx:2A5#00 03 4F 8F 85 59 8E DA
>          rx:2A5#00 00 85 9A EF 54 34 5D
> .c (700) fail
> 0: RX (004/003)  2A5#00 00 85 9A EF 54 34 5D    ???
                   Not RX'ed by hardware
> 0: RX (004/002)  2A5#00 00 85 9A EF 54 34 5D    ???
                   Not RX'ed by hardware

> 0: TX (003/002)  2A5#00 03 4F 8F 85 59 8E DA    TX 0x03 -> RX 0x03 !!!
                   Not RX'ed by application

In the hardware the message is in the TX FIFO at offset 0x03 and in RX
0x03.

> 0: RX (003/001)  2A5#00 01 7C 30 5C 7A 2D 1C    RX 0x01
> 0: TX (002/001)  2A5#00 02 6A 8F 6C 81 C3 B0    TX 0x02 -> RX 0x02 !!!
                   Not RX'ed by application

In the hardware the message is in the TX FIFO at offset 0x02 and in RX
0x02.

> 0: RX (002/000)  2A5#00 00 AC AF 70 9B 32 03    RX 0x00
> 0: TX (001/000)  2A5#00 01 7C 30 5C 7A 2D 1C    TX 0x01 -> RX 0x01

In the hardware the message is in the TX FIFO at offset 0x01 and in RX
0x01.

> 0: TX (000/000)  2A5#00 00 AC AF 70 9B 32 03    TX 0x00 -> RX 0x00

In the hardware the message is in the TX FIFO at offset 0x00 and in RX
0x00.

> 0: RX (004/003)  2A5#00 03 65 32 F8 E7 E6 F5    RX 0x0f
> 0: RX (004/002)  2A5#00 02 CC D5 09 FE 55 99    RX 0x0e
> 0: TX (003/002)  2A5#00 03 65 32 F8 E7 E6 F5
> 0: RX (003/001)  2A5#00 01 62 4F 17 34 44 CE    RX 0x0d
> 0: TX (002/001)  2A5#00 02 CC D5 09 FE 55 99
> 0: RX (002/000)  2A5#00 00 FE 58 FE FD C0 EF    RX 0x0c
> 0: TX (001/000)  2A5#00 01 62 4F 17 34 44 CE
> 0: TX (000/000)  2A5#00 00 FE 58 FE FD C0 EF
> 0: RX (004/003)  2A5#00 03 C9 7B EF 83 93 E0    RX 0x0b
> 0: RX (004/002)  2A5#00 02 DD 5E 82 B4 FD C4    RX 0x0a
> 0: TX (003/002)  2A5#00 03 C9 7B EF 83 93 E0
> 0: RX (003/001)  2A5#00 01 90 3B 32 80 90 67    RX 0x09
> 0: TX (002/001)  2A5#00 02 DD 5E 82 B4 FD C4
> 0: RX (002/000)  2A5#00 00 8F 28 D2 F5 B6 98    RX 0x08
> 0: TX (001/000)  2A5#00 01 90 3B 32 80 90 67
> 0: TX (000/000)  2A5#00 00 8F 28 D2 F5 B6 98
> 0: RX (004/003)  2A5#00 03 C5 1E FE 68 F1 65    RX 0x07
> 0: RX (004/002)  2A5#00 02 7E 2B BA 18 F1 7B    RX 0x06
> 0: TX (003/002)  2A5#00 03 C5 1E FE 68 F1 65
> 0: RX (003/001)  2A5#00 01 CE 1B D7 9E 42 15    RX 0x05
> 0: TX (002/001)  2A5#00 02 7E 2B BA 18 F1 7B
> 0: RX (002/000)  2A5#00 00 85 9A EF 54 34 5D    RX 0x04
> 0: TX (001/000)  2A5#00 01 CE 1B D7 9E 42 15
> 0: TX (000/000)  2A5#00 00 85 9A EF 54 34 5D

Can you run this in parallel to the test. Abort with Ctrl+c after the
test fails and send me the log file. The last 256 lines should be
enough.

| candump any,0:0,#FFFFFFFF -l

The candump writes to current dir by default. To avoid side effects
change to a tmpfs, if you have enough RAM :).

Also send the regmap dump and of course the error message of the test
tool.

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79C629410A
	for <lists+linux-can@lfdr.de>; Tue, 20 Oct 2020 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395098AbgJTREN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Oct 2020 13:04:13 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:17871 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395096AbgJTREN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Oct 2020 13:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603213451;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=7vPgYzt7+497NE31Mut8+op76wscvx3QrmZea51uhVE=;
        b=emb3Binfk4U3w1Kq1HKytHxIVNHmOSpKYwOmPnsFOapPEX+eUxh24rjeycz0nVC50M
        ASVszUgDpVBgpfq1BdCg2jhBBFHKIoSE8cfAxIh0+fOTx3uVwKVCjnx7LBM71bCF4a0s
        l/1O7tRaQvusOFyAdR+84IsQh6YO5FvJWcEH/cdckcaeKic3K6U7AUQ/s0lIAfu1at+1
        kgFV/Hhii6+fkhpBsOE94s0SsGeATSQPwGJgpaZ8qrersz79AcqxuX9lmbCR6Ls1VxPp
        WB9hQOF45jmZG6+/L4g1T96CeXjwTqazxqJuZfVX9GHy8PYfq9pjYDkbWStczMSRsB0U
        p5jQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJU8h6kEyi"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9KH4AoJZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 20 Oct 2020 19:04:10 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
 <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
Date:   Tue, 20 Oct 2020 19:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 20.10.20 18:07, Vincent Mailhol wrote:

> I also did the test. I can send a CAN with a DLC of 13 on one
> controller and the other ones correctly received a frame of 8 bytes
> with a DLC of 13.

o_O

You see me perplexed ...

> After, I am not saying that absolutely all the controllers will allow
> DLC greater than 8. I would not be surprised to see some controllers
> attempting to do some sanitization (which would violate the ISO) and
> maybe you did your testing on such controllers. Only thing I can tell
> is that all the controllers I studied allowed it (I can give more
> examples upon request).

I believe you.

> As for security testing, I worked as a security consultant in the
> automotive industry for the last three years and with our colleagues,
> we witnessed some ECUs that would completely stop responding after
> receiving some DLCs greater than 8 due to some buffer overflow. This
> is a real thing which can be found in production, I think it would be
> great to be able to test that using socket CAN.

Yes. That's a valid use-case. Many people are testing CAN setups based 
on SocketCAN. So getting every aspect of CAN available is needed to be 
able to provide a real OSS solution.

> Some professional tools such as the CAN testing suite of Defensics by
> Synopsys also include these kind of tests. Because Socket CAN does not
> support this, Synopsys actually recommends to use the proprietary
> drivers from the Peak controller which do allow this (unfortunately,
> the Defensics documentation is not available publicly so I can not
> give you a link to support my claim on that last example).

Stephane from PEAK is working on the Linux driver (Mainline Linux & PEAK 
chardev), so I put him on CC. Or are you referring to the Windows driver?

> I hope that I could highlight in this answer that I am more than just
> a hobbyist who got exited after ready the ISO and that I know this
> subject. What I explain here is well known in the niche community of
> automotive security researcher but outside of it I just think that
> people are not aware of it.

Well I have done a lot in automotive CAN security too - with message 
authentication and with CAN IDS - but this DLC thing was still new to me ...

 From a first thought I would see a new flag CAN_CTRLMODE_RAW_DLC in the 
netlink interface of IFLA_CAN_CTRLMODE for the CAN controller driver.

This could switch the sanitizing AND the CAN controller can properly 
expose its ability to support this mode.

I think I have to pick a beer and look at some code ... :-)

Best regards,
Oliver

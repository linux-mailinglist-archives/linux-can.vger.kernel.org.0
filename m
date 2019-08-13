Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E48B886
	for <lists+linux-can@lfdr.de>; Tue, 13 Aug 2019 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfHMM1s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Aug 2019 08:27:48 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:21439 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfHMM1s (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Aug 2019 08:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1565699263;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=M5760lRnFBzkVxOWq9hHcj8oQWcV1zKKFqVZSHe0dTA=;
        b=kvoiZfDB/OE73+1BYL5k+Tk2FcpFSxRBnBisiymoNT2mZr5GcxCh/Na4L710fzMo9/
        Xv06jQiYCYgiiy1VOA3LvBt09fpQQIrPocRp+PjI9R9oYZeSNTZuyY9L+CYC63OfM89b
        +YurEJQ2P604369CnIeR/PyVBM2kkYlqpRRaFtFap9r8EWsOtPt6dBCj2Ml9GMV+Qm2Z
        6ARai+txKbBf4sfgKkB/C9MG9W8pfoITzHQDNWitiX5uHVfcQXYTkGDAyI50SHmIYJEd
        l3TOMs8bkgBUJ8bIYZ+QZEaMUSUECyWfBPKZvjICl+6uqAFVR8SPjGLecf2qlo3Jm4Wh
        RALA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVsh5lEw8"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.26.1 DYNA|AUTH)
        with ESMTPSA id R073b7v7DCRb061
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 13 Aug 2019 14:27:37 +0200 (CEST)
Subject: Re: Mainline status for "can/bcm: Replace hrtimer_tasklet with
 softirq based hrtimer"?
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-can <linux-can@vger.kernel.org>
References: <20171022213938.940451689@linutronix.de>
 <20171022214053.508480159@linutronix.de>
 <15b391b9-ad47-c5b6-a6be-bdb4a336c968@hartkopp.net>
 <a36f5369-d66a-dbb8-9a77-7bcefa432ce1@hartkopp.net>
 <alpine.DEB.2.20.1711291358160.2056@hypnos.tec.linutronix.de>
 <5e744197-005a-a941-9372-810586f64157@hartkopp.net>
 <alpine.DEB.2.21.1908122028470.7324@nanos.tec.linutronix.de>
 <20190813072427.i6ieuahddhveku6f@linutronix.de>
 <92c6a310-ce5f-b5fa-e532-c193023bc729@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <03bb7a58-3e80-2c21-2462-97ff7058dd7b@hartkopp.net>
Date:   Tue, 13 Aug 2019 14:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <92c6a310-ce5f-b5fa-e532-c193023bc729@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 13/08/2019 11.30, Marc Kleine-Budde wrote:
> On 8/13/19 9:24 AM, Sebastian Sewior wrote:
>> On 2019-08-12 20:31:34 [+0200], Thomas Gleixner wrote:
>>> I was assuming this goes through the can/net process. So TBH, I did not pay
>>> attention as this was not using that old crufty hrtimer_tasklet() construct
>>> which we removed.
>>
>> The mvpp2 driver fell through the cracks as well. I will repost that
>> one…
>>
>> Oliver, I believe you can handle the can driver yourself, right?
> 
> I've added the patch to can-next and it will be included in the next
> pull request to David Miller.

Thanks all!

I was really happy to get the hrtimer trampoline stuff reverted in the 
code again. Thanks for your effort! I needed some time to review the 
changes as the trampoline approach included weird complexity that time :-)

@Marc: Please add my Acked-by: if it's still missing in the current 
upstream patch. Tnx!

Best,
Oliver

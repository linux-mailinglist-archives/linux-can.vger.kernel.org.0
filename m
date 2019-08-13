Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D632C8B0A1
	for <lists+linux-can@lfdr.de>; Tue, 13 Aug 2019 09:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfHMHYa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 13 Aug 2019 03:24:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33005 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfHMHYa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Aug 2019 03:24:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxRAS-0006LN-7q; Tue, 13 Aug 2019 09:24:28 +0200
Date:   Tue, 13 Aug 2019 09:24:28 +0200
From:   Sebastian Sewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: Mainline status for "can/bcm: Replace hrtimer_tasklet with
 softirq based hrtimer"?
Message-ID: <20190813072427.i6ieuahddhveku6f@linutronix.de>
References: <20171022213938.940451689@linutronix.de>
 <20171022214053.508480159@linutronix.de>
 <15b391b9-ad47-c5b6-a6be-bdb4a336c968@hartkopp.net>
 <a36f5369-d66a-dbb8-9a77-7bcefa432ce1@hartkopp.net>
 <alpine.DEB.2.20.1711291358160.2056@hypnos.tec.linutronix.de>
 <5e744197-005a-a941-9372-810586f64157@hartkopp.net>
 <alpine.DEB.2.21.1908122028470.7324@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.DEB.2.21.1908122028470.7324@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2019-08-12 20:31:34 [+0200], Thomas Gleixner wrote:
> I was assuming this goes through the can/net process. So TBH, I did not pay
> attention as this was not using that old crufty hrtimer_tasklet() construct
> which we removed.

The mvpp2 driver fell through the cracks as well. I will repost that
one…

Oliver, I believe you can handle the can driver yourself, right?

> Thanks,
> 
> 	Thomas

Sebastian

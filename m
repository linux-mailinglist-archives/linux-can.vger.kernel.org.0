Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6218A659
	for <lists+linux-can@lfdr.de>; Mon, 12 Aug 2019 20:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfHLSbn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Aug 2019 14:31:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLSbm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Aug 2019 14:31:42 -0400
Received: from p200300ddd71876867e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7686:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hxF6a-0003Ym-DG; Mon, 12 Aug 2019 20:31:40 +0200
Date:   Mon, 12 Aug 2019 20:31:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: Mainline status for "can/bcm: Replace hrtimer_tasklet with
 softirq based hrtimer"?
In-Reply-To: <5e744197-005a-a941-9372-810586f64157@hartkopp.net>
Message-ID: <alpine.DEB.2.21.1908122028470.7324@nanos.tec.linutronix.de>
References: <20171022213938.940451689@linutronix.de> <20171022214053.508480159@linutronix.de> <15b391b9-ad47-c5b6-a6be-bdb4a336c968@hartkopp.net> <a36f5369-d66a-dbb8-9a77-7bcefa432ce1@hartkopp.net> <alpine.DEB.2.20.1711291358160.2056@hypnos.tec.linutronix.de>
 <5e744197-005a-a941-9372-810586f64157@hartkopp.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Oliver,

On Sun, 11 Aug 2019, Oliver Hartkopp wrote:
> 
> I'm monitoring this patch from Thomas & Anna-Maria for nearly two years now -
> and I also gave my Acked-by some time ago.
> 
> As Tom is continuously applying th patch to the RT trees:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/net/can?h=v4.14-rt-rebase&id=49e2a1e5fef75738f536c0ed0fea9b6c1f3b46c1
> 
> Are there any plans to push this patch to mainline Linux or will this patch be
> applied together with a huge patch set when RT completely gets into mainline?
> 
> We can also use the common upstream process via linux-can mailing list.

I was assuming this goes through the can/net process. So TBH, I did not pay
attention as this was not using that old crufty hrtimer_tasklet() construct
which we removed.

But yes, the patch makes sense independent of RT anyway as it removes one
level of indirection.

Thanks,

	Thomas



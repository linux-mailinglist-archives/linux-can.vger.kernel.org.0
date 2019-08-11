Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B638589316
	for <lists+linux-can@lfdr.de>; Sun, 11 Aug 2019 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfHKSXt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Aug 2019 14:23:49 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:23377 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKSXt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Aug 2019 14:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1565547827;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NcGriEOx3qHoOZfxsyrRRHLjBX2HFlydllWwydbMyBU=;
        b=ag78OSCtQ7Hf9rPmjyotf2bqqTSdnQOPinmGHoHDuBFBL0HnDg7VgB6NHFsCIf7//6
        o7HCyZozWjagLtBZCF7fjIzrzFntj7xauW80uv1Y+eWo93vb6pFtByVZCAWeAt5rjfoL
        Gzr+rSRBHMRlSR0XxaTWTb5wzFoBQ7V0yMQlPzDo6A2dw3p5Mm92LpTgqU4WNvnQXPBK
        psrVPlLNAdTnZ/5QRwxR/uqLpjjifCc/RVG/lBu0nKbHrl+SNIu8WGWD3V9NSX94OpiK
        Nj8/0f9vfTi9EMyr/EpOgRN8opa210fnB9P5mDCUHLDuE4cdCNJJvu8xC+Jj+EfK7XuI
        QlAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT57TxlT8iMGw="
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv7BINgVzW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 11 Aug 2019 20:23:42 +0200 (CEST)
Subject: Mainline status for "can/bcm: Replace hrtimer_tasklet with softirq
 based hrtimer"?
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <20171022213938.940451689@linutronix.de>
 <20171022214053.508480159@linutronix.de>
 <15b391b9-ad47-c5b6-a6be-bdb4a336c968@hartkopp.net>
 <a36f5369-d66a-dbb8-9a77-7bcefa432ce1@hartkopp.net>
 <alpine.DEB.2.20.1711291358160.2056@hypnos.tec.linutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <5e744197-005a-a941-9372-810586f64157@hartkopp.net>
Date:   Sun, 11 Aug 2019 20:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1711291358160.2056@hypnos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

I'm monitoring this patch from Thomas & Anna-Maria for nearly two years 
now - and I also gave my Acked-by some time ago.

As Tom is continuously applying th patch to the RT trees:

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/net/can?h=v4.14-rt-rebase&id=49e2a1e5fef75738f536c0ed0fea9b6c1f3b46c1

Are there any plans to push this patch to mainline Linux or will this 
patch be applied together with a huge patch set when RT completely gets 
into mainline?

We can also use the common upstream process via linux-can mailing list.

Best regards,
Oliver

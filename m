Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504D64EB1E7
	for <lists+linux-can@lfdr.de>; Tue, 29 Mar 2022 18:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiC2Qko (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Mar 2022 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiC2Qkm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Mar 2022 12:40:42 -0400
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E1BF01F;
        Tue, 29 Mar 2022 09:38:59 -0700 (PDT)
Received: from 1nZEru-0004Rr-Vx by out3b.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nZErw-0004Vp-V0; Tue, 29 Mar 2022 09:38:56 -0700
Received: by emcmailer; Tue, 29 Mar 2022 09:38:56 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3b.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nZEru-0004Rr-Vx; Tue, 29 Mar 2022 09:38:54 -0700
Received: from tsdebian (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 2B89219E96;
        Tue, 29 Mar 2022 09:38:54 -0700 (MST)
Message-ID: <1648571918.2364.1.camel@embeddedTS.com>
Subject: Re: [PATCH] drivers: Fix Links to Technologic Systems web resources
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>, wg@grandegger.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-can@vger.kernel.org
Date:   Tue, 29 Mar 2022 09:38:38 -0700
In-Reply-To: <CAMRc=MdZm1HU3vZcYK=cStmCE6+tQ6R4-ya5t3ZRovf0RZHJQQ@mail.gmail.com>
References: <20220303225525.29846-1-kris@embeddedTS.com>
         <CAMRc=McesjKviO=5gK3GN+XukZfSr=um9W8+sqXw9GSFX0QTgw@mail.gmail.com>
         <1648489760.3393.6.camel@embeddedTS.com>
         <20220328175857.dvmvh5knabc6sq3x@pengutronix.de>
         <CAMRc=MdZm1HU3vZcYK=cStmCE6+tQ6R4-ya5t3ZRovf0RZHJQQ@mail.gmail.com>
Organization: embeddedTS
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=R5FWcDFV1//6o1fZx2FXeDZPUb1MDiE+Q32sF2zL76w=;b=bUIrVpm99KX9/zh6Nmr3jutGAMA+7vvp4ghqal8KKdnbNwECcn/sD0MreaFL3N2YFUA4ZDjbHuIMIdt7UI0qm/7OKYwK78z6VO0AN9Gfp3UaXpuLg6f/lcy3gVYileLDN84uL406Hy7+8GdKE01ypf+Dnmw5aiyADL05CfqgJuxdzg9evCY8QkAXnKn1CJ++ZnKGZZeMxxdivByjXMXROWwmwYizY8L+fjvM+Kt12rCLPb61MTYmHERvF4EgV81tu2VvmRQspw6p2NHZZr5C5lNfAPosQPE7d6Ab7I+lFVIdk93n5wAAJpltoVAnuQhim0g5yU3B14Nj14MepQzTrw==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 2022-03-29 at 15:18 +0200, Bartosz Golaszewski wrote:
> On Mon, Mar 28, 2022 at 7:58 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > 
> > I'm taking the CAN part. I think it's best to repost the GPIO part as a
> > separate patch.
> > 
> 
> Yes please, and for the future: if possible separate such changes into
> patches aimed at different maintainers.
> 
> Bart
> 

Understood. Thank you for the information.

Kris

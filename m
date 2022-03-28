Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB64E9DD7
	for <lists+linux-can@lfdr.de>; Mon, 28 Mar 2022 19:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244709AbiC1Rvb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Mar 2022 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbiC1Rva (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Mar 2022 13:51:30 -0400
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194493C4BE;
        Mon, 28 Mar 2022 10:49:49 -0700 (PDT)
Received: from 1nYtUr-000AOq-TC by out3a.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nYtUu-000AW5-W3; Mon, 28 Mar 2022 10:49:44 -0700
Received: by emcmailer; Mon, 28 Mar 2022 10:49:44 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3a.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nYtUr-000AOq-TC; Mon, 28 Mar 2022 10:49:41 -0700
Received: from tsdebian (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 49F2C18292;
        Mon, 28 Mar 2022 10:49:40 -0700 (MST)
Message-ID: <1648489760.3393.6.camel@embeddedTS.com>
Subject: Re: [PATCH] drivers: Fix Links to Technologic Systems web resources
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>, wg@grandegger.com,
        mkl@pengutronix.de,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-can@vger.kernel.org
Date:   Mon, 28 Mar 2022 10:49:20 -0700
In-Reply-To: <CAMRc=McesjKviO=5gK3GN+XukZfSr=um9W8+sqXw9GSFX0QTgw@mail.gmail.com>
References: <20220303225525.29846-1-kris@embeddedTS.com>
         <CAMRc=McesjKviO=5gK3GN+XukZfSr=um9W8+sqXw9GSFX0QTgw@mail.gmail.com>
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
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=nKiFYIXDw4n2cOLH2b1x2SJAtQVR0gy/UjvNfA/2kek=;b=J0KzP76FUD7G9njy03S8nwISuL3YMik1Cq12pL6jUfgqQtflVX0GQuph6qe2QdwdYMOLsL+KxPCm2KRx/CQ4mKIa3+fN85Nfs6pISbB6NXECj0py10VFoq1zO3CQJ5Een68rJKy7ClWmA/jjCJylulA2onNjLLjQChXWfReWHN+49ciNAz6LN/+FnfZ1bFnzhxIj+ga8QKZycYJAidSsYT2/8g0g/W3yqr6eLncIQjoUyz4xfNSr1QFyDhZCFJC5e/qeONxhOVzOBkyp2ZC35+YUBGwtberApNlJv/drkgpElxWXGpMIh0gYz9l5TlaTBn5PG5PizYXiwV3Lptxz/g==;
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

On Fri, 2022-03-04 at 08:24 +0100, Marc Kleine-Budde wrote:
> 
> For the CAN part:
> 
> Acked-by: Marc Kleine-Budde
> 
> regards,
> Marc

On Mon, 2022-03-07 at 10:22 +0100, Bartosz Golaszewski wrote:
> 
> For GPIO
> 
> Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
> 


Inquiring about the status of this patch. I have not seen it show up in
any repositories. Is there any other action I need to take at this time?
Apologies if this time frame is normal for such a low priority patch, I
am not sure what to expect. Thanks!

Kris

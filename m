Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E04BFCA4
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiBVPcj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiBVPcj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:32:39 -0500
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8AC792D
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:32:13 -0800 (PST)
Received: from skn-laptop.hadsten (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 21C6A1296D9;
        Tue, 22 Feb 2022 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1645543931; bh=hCU/7EfQ6WOIpnsBhpqeYJ0/YCqfqvi9DhS2RbAuP38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aBlAJHhbP9RTPtSzDJG4sWpXOubMmQxYO2smGI8Sng9CZ2mKni6vB033uhRi+UL/N
         UmgX7I2LQ3gu3fcrR1df2Yzp6BBe+JLmtmy/IhupWNlF/jq3xj58EOYTNot8VXjAtJ
         ULc9H72uarxMKYeO0b7sd5/+QGdiU3mf9oqqFhYiOQi0Bc7m3NNdEz5vyyCxRsFkkr
         PnC5j/+jsEBbbgcVqjtrW/80v32wiimKrHcY+wWSi2naq+HE/UdQ549IUFqMBmotjy
         aJe2gW2/6fSlnHxgK9jcwoTaDYXfzovynWiSSmYqdYxg93EvgrqJs4nhhJfBEBdGqt
         qFFBC1g8tZ0ww==
Date:   Tue, 22 Feb 2022 16:32:10 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x: wake pin
Message-ID: <20220222153210.32ro3rmdpi7a3f2a@skn-laptop.hadsten>
References: <20220222150334.rbhm3uzbh4jp4ap4@skn-laptop.hadsten>
 <20220222151901.tn5sq6ihbaycwiuo@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220222151901.tn5sq6ihbaycwiuo@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Feb 22, 2022 at 04:19:01PM +0100, Marc Kleine-Budde wrote:
> On 22.02.2022 16:03:34, Sean Nyekjaer wrote:
> > The TCAN4x5x device have 2 wake pins. One for waking the host controller
> > and one for waking the tcan controller it self.
> > 
> > We only have the wake for the tcan controller it self implemented
> > right?
> 
> Sort of. The tcan driver contains handling for the device_state_gpio. I
> think should be the pin from the tcan to SoC. The handling of this pin
> looks fishy.

Ah, Okay so state-gpio maps to nWKRQ and wake-gpio maps to WAKE.
I don't think one should wire the WAKE pin to the SoC.

> 
> > I have a task that would enable our host to wake-on-can traffic.
> 
> Due to lack of time, I haven't looked deeply into the sleep and wakeup
> of the tcan and the wake from the tcan towards the SoC. As said above,
> the device_state_gpio handling looks fishy. Probably first remove the
> device_state_gpio handling from the driver, add missing power management
> to the m_can and tcan driver, then add wakeup support.

The task just grew, will see when I get time ...

> 
> Have a look at this series, I haven't reviewed it in detail, but it
> looks good at the first glance.
> 
> | https://lore.kernel.org/all/20220111002109.927308-1-phil@quantulum.co.uk

Thanks

/Sean

Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E31758ADE
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 03:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjGSBdS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 21:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGSBdS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 21:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5410D1BC9
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 18:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A5F612CF
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 01:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA38C433C8;
        Wed, 19 Jul 2023 01:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689730396;
        bh=cnB634d5MilJx61cRbzEaIgLNrGvhl8lhYE1cM+RK3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=joJppOyiXXcr17Mg9CVU5knqiGd6Wk7zb0/Ghi7YXkFsjmOUhKagdbWS1kjBBZ2nw
         KvVPD+k6NvIKErN++63eeAU5Jn9uDpbteK6pfLChEkafjptVKkoiT1jS0+hZ52Ol76
         BDF94l3Zh/g4p1+yZlCr9xyU27X+HPKcf/i7cb6ccShJ30FFmo6i1oq+zkk/lB3ECu
         gUPZGnzTV0NutlXrUZG4X50Jp7BrrcKWtRPCoxrETTA/V7t4TYXscaBGJptt9EibdD
         MM7iespl5Wp9rAWI93m9h0MzlP83OV2qPH7pfkPuZNXgtP+/CTTCiJ/R+miawAvdAO
         cVQw+SxFuJ85g==
Date:   Tue, 18 Jul 2023 18:33:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Jimmy Assarsson <extja@kvaser.com>,
        Martin Jocic <majoc@kvaser.com>
Subject: Re: [PATCH net-next 7/8] can: kvaser_pciefd: Move hardware specific
 constants and functions into a driver_data struct
Message-ID: <20230718183315.27c0cd27@kernel.org>
In-Reply-To: <20230717182229.250565-8-mkl@pengutronix.de>
References: <20230717182229.250565-1-mkl@pengutronix.de>
        <20230717182229.250565-8-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, 17 Jul 2023 20:22:28 +0200 Marc Kleine-Budde wrote:
> +const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {

> +const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask = {

> +const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops = {

> +const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_data = {

sparse points out the structs in this and subsequent patch should
be static. Would you be able to queue a quick fix on top and resend,
or should we pull as is?

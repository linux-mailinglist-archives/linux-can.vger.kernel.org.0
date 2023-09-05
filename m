Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F508792FAB
	for <lists+linux-can@lfdr.de>; Tue,  5 Sep 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbjIEUOG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Sep 2023 16:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243451AbjIEUNu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Sep 2023 16:13:50 -0400
X-Greylist: delayed 294 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:13:32 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0237B1B4
        for <linux-can@vger.kernel.org>; Tue,  5 Sep 2023 13:13:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3893C433C9;
        Tue,  5 Sep 2023 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693936937;
        bh=xtoJaatQ/1C8wi9mzYWBCRGcYEDArwLrXMVOyAABDe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OR4kCKWGEVSZLtIbLQbUrcEzJq75KIBc+VrWW4wgt6wlQVYxjoBLGILlbbSiQPHRY
         MoJlwU8aIRVbLDQyQ9rvfyK83AmvEPridjfzOE3HpAC06PZvgyBowl/ST2PwT57s1s
         XOELG+Jci/Pk9Ok8KilHChtsHBaNOncbx9qjmqmgYDCMcNNpXfWZUeXTZOx6ivV0LM
         7BFQIxI+UOHexQmZgVRDuuOCnrzNncqry6MqjN1AORUV/+TOHys8lMndjAnKqdcj/1
         mDqU23j9PFEp6urkD0YirdVUUTDaR5CRCTWrfitPetXsE4LzSZFP/XNIlFbAL77/0L
         beMfY0fh0pFqg==
Received: (nullmailer pid 3669220 invoked by uid 1000);
        Tue, 05 Sep 2023 18:02:15 -0000
Date:   Tue, 5 Sep 2023 13:02:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH] of: overlay: Fix of_overlay_fdt_apply prototype when
 !CONFIG_OF_OVERLAY
Message-ID: <169393693413.3669145.6896827224153747407.robh@kernel.org>
References: <20230904100002.7913-1-pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904100002.7913-1-pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On Mon, 04 Sep 2023 12:00:02 +0200, Pavel Pisa wrote:
> The of_overlay_fdt_apply has been changed but when CONFIG_OF_OVERLAY
> support is not configured then old stub prototype is declared
> by of.h header.
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  include/linux/of.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!


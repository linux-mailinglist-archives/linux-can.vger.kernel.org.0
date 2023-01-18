Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5F6724D8
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 18:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjARR2V (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 12:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARR2V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 12:28:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BF14E88
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 09:28:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D31D1CE1C4D
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 17:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B827C433F0;
        Wed, 18 Jan 2023 17:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674062897;
        bh=i/molI4igSdPuWthi1ooT7FdJi3hNe5JxLCaHL+bYLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFB0sDSoMq1O+pmytzNxTTzcuXWOzTzY9OlEmrOPKuLTHBWOk9cSTSuTH4MXRbl6E
         TAImPNTMbI6mKtU8nEGK5HPlLmt1Z6OTsFfPoolAi4RAp22NAqarIg3TN6z3VaI5PJ
         QIBAu4x4cA96s/KEDmJSavvkuG1c0u7hfoBsjEhV9lUW2qpiUd9EWt+3EnruB3qMIi
         NjcWytDhCPqT9NXQe5tuuYtou/Ng6rh050/ycfw0FG455wzWEno/DAgTMvYtZ2lBzQ
         UePcwUmib30SAxeuZYovalXrzH1lxTvV+cXN0zX/6eDVU6ZEO4dNFhMlx+crqbc4Kq
         SPPdbYjWtnrqQ==
Date:   Wed, 18 Jan 2023 22:58:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-can@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH] phy: phy-can-transceiver: Skip warning if no
 "max-bitrate"
Message-ID: <Y8gsLbKGDWZgzAeA@matsya>
References: <88e158f97dd52ebaa7126cd9631f34764b9c0795.1674037334.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e158f97dd52ebaa7126cd9631f34764b9c0795.1674037334.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 18-01-23, 11:29, Geert Uytterhoeven wrote:
> According to the DT bindings, the "max-bitrate" property is optional.
> However, when it is not present, a warning is printed.
> Fix this by adding a missing check for -EINVAL.

Applied, thanks

-- 
~Vinod

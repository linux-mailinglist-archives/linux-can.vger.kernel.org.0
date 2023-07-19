Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543F6758AEE
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 03:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjGSBkX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 21:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSBkW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 21:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334871BD6;
        Tue, 18 Jul 2023 18:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAEB661680;
        Wed, 19 Jul 2023 01:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13D8DC433C7;
        Wed, 19 Jul 2023 01:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689730821;
        bh=Z0TyEYtGqfI6IcND0lcSyqGPYZx0ajPjBcu/XotKGcw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CqYT9gy4epOXt6zQpL/m5n6BiQztEEgdDmrpxSQ0GTZaeKUvOXCSatuMRkBsfrcaI
         fmOw8iuqTSHdLbus8OimQFigPKKwGwEWjWxa0N3r1kPirB+rMNQidm1/AYZIrYh9kP
         ekkFOm0qPGTD6rSqxjx8+bgXDXlFVI9Urak7JF+ABolxiWXqZWD4Jo/NkYv/aaAPqt
         b+qBq9OzLpEdFpyN3f6FeE8tXdqkrj3BOQgQQPrW5lpt9rjRItB6jfjFT6hknjbFog
         nc0yksKBqbbqOlgrv8dhBcbpxKUcJ+mgqf2gSrmELi85bv94zEDHD/7pNDyM1IkUCj
         j7jSDa2KOzPIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E05F7E22AE0;
        Wed, 19 Jul 2023 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] can: raw: fix receiver memory leak
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168973082091.10560.7182619527362375946.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 01:40:20 +0000
References: <20230717180938.230816-2-mkl@pengutronix.de>
In-Reply-To: <20230717180938.230816-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        william.xuanziyang@huawei.com, socketcan@hartkopp.net,
        stable@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon, 17 Jul 2023 20:09:34 +0200 you wrote:
> From: Ziyang Xuan <william.xuanziyang@huawei.com>
> 
> Got kmemleak errors with the following ltp can_filter testcase:
> 
> for ((i=1; i<=100; i++))
> do
>         ./can_filter &
>         sleep 0.1
> done
> 
> [...]

Here is the summary with links:
  - [net,1/5] can: raw: fix receiver memory leak
    https://git.kernel.org/netdev/net/c/ee8b94c8510c
  - [net,2/5] can: bcm: Fix UAF in bcm_proc_show()
    https://git.kernel.org/netdev/net/c/55c3b96074f3
  - [net,3/5] can: gs_usb: gs_can_open(): improve error handling
    https://git.kernel.org/netdev/net/c/2603be9e8167
  - [net,4/5] can: gs_usb: fix time stamp counter initialization
    https://git.kernel.org/netdev/net/c/5886e4d5ecec
  - [net,5/5] can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout
    https://git.kernel.org/netdev/net/c/9efa1a5407e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



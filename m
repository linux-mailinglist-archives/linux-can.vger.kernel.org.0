Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50994707D3B
	for <lists+linux-can@lfdr.de>; Thu, 18 May 2023 11:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjERJuY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 May 2023 05:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjERJuX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 May 2023 05:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFD710E9;
        Thu, 18 May 2023 02:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A3761BEC;
        Thu, 18 May 2023 09:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 597F9C433D2;
        Thu, 18 May 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684403421;
        bh=YuqJpie3wbBWpQm9NgRx+KpxOF9/4v76k+sZ8xMuD7U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bDA4SjLU88uNAWLJlNsTLziWS62ON/if7D79DeMxFWOqnoAen/O79zE/EQOApyzEJ
         orG5daSwHMedMe6Zhsrgq+bCqbKRf0MHDC8GKNkDA6j0OZhS2yEsGk77Od5GEDp9Ar
         J3dvJMrMG2GHbMQX4vTRAe4BsjtFkRP9wqk4Ls8VHtWQ3OMrY5Mj3VjCTMMYMV56ay
         O9nVzYKdfOs1YeAyq43w+82lig/9bc7kXoLzCygmJ/lPNrLEAWxRApugSuzNeNx5Pc
         X09goE37DNvsP1N+D2G0rKqinZD2ZTdoXvIzKtyj+l4ot+wXKo/BQleX0fXPbpii3+
         T016NQ3R/gEWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E0AAC32795;
        Thu, 18 May 2023 09:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/7] can: kvaser_pciefd: Set CAN_STATE_STOPPED in
 kvaser_pciefd_stop()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168440342124.5221.213514877064037706.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 09:50:21 +0000
References: <20230518073241.1110453-2-mkl@pengutronix.de>
In-Reply-To: <20230518073241.1110453-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de, extja@kvaser.com,
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

On Thu, 18 May 2023 09:32:35 +0200 you wrote:
> From: Jimmy Assarsson <extja@kvaser.com>
> 
> Set can.state to CAN_STATE_STOPPED in kvaser_pciefd_stop().
> Without this fix, wrong CAN state was repported after the interface was
> brought down.
> 
> Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> Link: https://lore.kernel.org/r/20230516134318.104279-2-extja@kvaser.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,1/7] can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()
    https://git.kernel.org/netdev/net/c/aed0e6ca7dbb
  - [net,2/7] can: kvaser_pciefd: Clear listen-only bit if not explicitly requested
    https://git.kernel.org/netdev/net/c/bf7ac55e991c
  - [net,3/7] can: kvaser_pciefd: Call request_irq() before enabling interrupts
    https://git.kernel.org/netdev/net/c/84762d8da89d
  - [net,4/7] can: kvaser_pciefd: Empty SRB buffer in probe
    https://git.kernel.org/netdev/net/c/c589557dd142
  - [net,5/7] can: kvaser_pciefd: Do not send EFLUSH command on TFD interrupt
    https://git.kernel.org/netdev/net/c/262d7a52ba27
  - [net,6/7] can: kvaser_pciefd: Disable interrupts in probe error path
    https://git.kernel.org/netdev/net/c/11164bc39459
  - [net,7/7] Revert "ARM: dts: stm32: add CAN support on stm32f746"
    https://git.kernel.org/netdev/net/c/36a6418bb125

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



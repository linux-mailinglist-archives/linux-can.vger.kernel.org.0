Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4737603C3
	for <lists+linux-can@lfdr.de>; Tue, 25 Jul 2023 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjGYAUZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Jul 2023 20:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjGYAUX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jul 2023 20:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB46172B;
        Mon, 24 Jul 2023 17:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E6F6147B;
        Tue, 25 Jul 2023 00:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27D06C433CB;
        Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690244421;
        bh=c+BzqUQbiiMX/ltbMk+0YwPg8Ke15f2UHcVMv7m/L4o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=E0IGGztj+9WgtRiHrzWo4cwHArx9vVqFr+RTqChJwPEb7c1/nbTCSXN33kgQf1zJ6
         5Hhg6H5revqSUXvYRxcDVjNICA4YqeBPHhgLlqUcj0+Yw9l0eOOlmXZxjeVWnSFiJW
         J6hQTjrVUB8NgUId6qbQmkj+iY9n0EZlkEpIeeDy3P6WRZVuFZj9bj8hjBU+nfsgC4
         5ALMK+IgrMhw7v47Q9XzDB5cCSGoKhejIACIE+LRIixm5MCftFAYWVmvVh1xmaJgem
         sDlWv6RHMcshFSxNWKLUaVHsbbE3cRc8Y2d2UBkz8Eic/QguqGUQyZAUQjBjtQKkmk
         AlHmaBbHiuf8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EF1BE21EE0;
        Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] can: gs_usb: gs_can_close(): add missing set of CAN
 state to CAN_STATE_STOPPED
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169024442105.15014.10559557791748669718.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jul 2023 00:20:21 +0000
References: <20230724150141.766047-2-mkl@pengutronix.de>
In-Reply-To: <20230724150141.766047-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
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

On Mon, 24 Jul 2023 17:01:40 +0200 you wrote:
> After an initial link up the CAN device is in ERROR-ACTIVE mode. Due
> to a missing CAN_STATE_STOPPED in gs_can_close() it doesn't change to
> STOPPED after a link down:
> 
> | ip link set dev can0 up
> | ip link set dev can0 down
> | ip --details link show can0
> | 13: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
> |     link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
> |     can state ERROR-ACTIVE restart-ms 1000
> 
> [...]

Here is the summary with links:
  - [net,1/2] can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED
    https://git.kernel.org/netdev/net/c/f8a2da6ec241
  - [net,2/2] can: raw: fix lockdep issue in raw_release()
    https://git.kernel.org/netdev/net/c/11c9027c983e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



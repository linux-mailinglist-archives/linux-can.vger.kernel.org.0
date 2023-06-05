Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7B72237B
	for <lists+linux-can@lfdr.de>; Mon,  5 Jun 2023 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjFEKa1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Jun 2023 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjFEKa0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Jun 2023 06:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C210A6;
        Mon,  5 Jun 2023 03:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99E4E6225C;
        Mon,  5 Jun 2023 10:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1616C4339B;
        Mon,  5 Jun 2023 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961021;
        bh=oPGdpYdRGs5prRqPkvlFOvNPOsOWKAiytl1FiPVuBog=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f8lVuGxiC3+QUoqXniT8IKHc2GKtV7BvQ1DZPsibcYH9MnXwdAIVt268Bp9wTbqOr
         yq+DQYJnAdbyKYHNA5EDKYy1uT08SkDvEIR9ccms1r3i1gm9ogcOhWgv0oT7WOp8+M
         184iqTzGxu8Aw2u6gNySr+wois693lz6FIcbf6U4c5AoxQggs0lr6AN6jHmQKmRfFu
         MeANAsCaFJlVFbISZJSAdCsMfuIOneSEJiNYj6vTtSFaU7cp/8izcvlnAqVX5jYF4n
         K7+6DpjewC2m6RA1mgZHjPtzFYSd/ZSJ4T3bb32tTWI5urie3pjozB+qSIo0eeCZoJ
         b46GFOtQDYVzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D357CE87231;
        Mon,  5 Jun 2023 10:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] can: j1939: j1939_sk_send_loop_abort(): improved
 error queue handling in J1939 Socket
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168596102085.26938.10931780487527852402.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Jun 2023 10:30:20 +0000
References: <20230605065952.1074928-2-mkl@pengutronix.de>
In-Reply-To: <20230605065952.1074928-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        o.rempel@pengutronix.de, david@protonic.nl, stable@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Mon,  5 Jun 2023 08:59:50 +0200 you wrote:
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> This patch addresses an issue within the j1939_sk_send_loop_abort()
> function in the j1939/socket.c file, specifically in the context of
> Transport Protocol (TP) sessions.
> 
> Without this patch, when a TP session is initiated and a Clear To Send
> (CTS) frame is received from the remote side requesting one data packet,
> the kernel dispatches the first Data Transport (DT) frame and then waits
> for the next CTS. If the remote side doesn't respond with another CTS,
> the kernel aborts due to a timeout. This leads to the user-space
> receiving an EPOLLERR on the socket, and the socket becomes active.
> 
> [...]

Here is the summary with links:
  - [net,1/3] can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket
    https://git.kernel.org/netdev/net/c/2a84aea80e92
  - [net,2/3] can: j1939: change j1939_netdev_lock type to mutex
    https://git.kernel.org/netdev/net/c/cd9c790de208
  - [net,3/3] can: j1939: avoid possible use-after-free when j1939_can_rx_register fails
    https://git.kernel.org/netdev/net/c/9f16eb106aa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2164B7C47FB
	for <lists+linux-can@lfdr.de>; Wed, 11 Oct 2023 04:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbjJKCua (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Oct 2023 22:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344862AbjJKCu1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Oct 2023 22:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90829D
        for <linux-can@vger.kernel.org>; Tue, 10 Oct 2023 19:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71A1DC433C8;
        Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696992625;
        bh=iH1pXtcYdrJ/QUVNvlYb9UCw+oTKoRBU1SAI2KI7rHE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ulHCjiRCpWSkJk4gmgmTpVeEQJNr9DOCanDdwAtYYxWZvqAMtu3eRAcgH+STXOTNB
         5Lgcp8ufFKLFEzorUnJoCV+nQl5a4KarQtr6dY6ygbLJzXWYBcKmCilHXCOLLXUUxZ
         aRo7dA0SA4s33Fk4uA0SfB3PIq3xndYutbCOMuLZ8LGeSRLvtUVKRyesjP1iPf0TLI
         BZ5lQ0dOtt0kWza9AHKM8TMHeX+B54jJsPiBHlgXfq2U0aWZc76mp6SIr4bv6gyg42
         srMmSbyzXaH7ITcabcOnruQmXP4qfv1XhMF8SW7itzblvZeqZxDS0HGwWcno6TXKRO
         TZhe9A4oAtdqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A77EE0009E;
        Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] can: isotp: isotp_sendmsg(): fix TX state detection
 and wait behavior
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169699262536.24203.1363184605761421124.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 02:50:25 +0000
References: <20231009085256.693378-2-mkl@pengutronix.de>
In-Reply-To: <20231009085256.693378-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        lukas.magel@posteo.net, maxime.jayat@mobile-devices.fr,
        socketcan@hartkopp.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon,  9 Oct 2023 10:50:03 +0200 you wrote:
> From: Lukas Magel <lukas.magel@posteo.net>
> 
> With patch [1], isotp_poll was updated to also queue the poller in the
> so->wait queue, which is used for send state changes. Since the queue
> now also contains polling tasks that are not interested in sending, the
> queue fill state can no longer be used as an indication of send
> readiness. As a consequence, nonblocking writes can lead to a race and
> lock-up of the socket if there is a second task polling the socket in
> parallel.
> 
> [...]

Here is the summary with links:
  - [net,1/6] can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior
    https://git.kernel.org/netdev/net/c/d9c2ba65e651
  - [net,2/6] can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set
    https://git.kernel.org/netdev/net/c/1f223208ebde
  - [net,3/6] arm64: dts: imx93: add the Flex-CAN stop mode by GPR
    https://git.kernel.org/netdev/net/c/23ed2be5404d
  - [net,4/6] can: sja1000: Always restart the Tx queue after an overrun
    https://git.kernel.org/netdev/net/c/b5efb4e6fbb0
  - [net,5/6] can: flexcan: remove the auto stop mode for IMX93
    https://git.kernel.org/netdev/net/c/63ead535570f
  - [net,6/6] can: tcan4x5x: Fix id2_register for tcan4553
    https://git.kernel.org/netdev/net/c/a9967c9ad290

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



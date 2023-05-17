Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F84705E7E
	for <lists+linux-can@lfdr.de>; Wed, 17 May 2023 06:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjEQEAa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 May 2023 00:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjEQEA3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 May 2023 00:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741D03A8D;
        Tue, 16 May 2023 21:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE38064182;
        Wed, 17 May 2023 04:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 554D0C433A1;
        Wed, 17 May 2023 04:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684296024;
        bh=VcGyi2cEUycSSurqDF8cL5uSfKMIcWqmuHxfeGZBgC0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CGBD3luDeY/n8Zq/uEbNLWm7TlmvbUPovje+ovN/geBzLfpxHH9wcdW9xzpdb2nHQ
         sDj5CtCj18/CTkBD/nS8f3zMX3omETsddAvr58IY5wDsAgOvzoW4l9TMnR/dEKtsbK
         TSZav9csSzAWWYIMuHrMm1Ugp8yCmr+LkhwxZPAttDK19UWIx2g+zVtEtuw/oD6kR+
         DQsMqsOmmLKZiRxR/G2u3NhAPQLPSw/NgqjrFZS9BeLQ0TpVGcIhVdiN3a6GrUPdrS
         /YtMR6K0WIQbOw+b7wytcYZSKOE6i1yPpp3Hmweszqk6rH3eGqrMTvLTGmYGaLwfVp
         wzQOlSlEJP9rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41451C73FE2;
        Wed, 17 May 2023 04:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/9] can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168429602426.23839.18000337535981617540.git-patchwork-notify@kernel.org>
Date:   Wed, 17 May 2023 04:00:24 +0000
References: <20230515204722.1000957-2-mkl@pengutronix.de>
In-Reply-To: <20230515204722.1000957-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        socketcan@hartkopp.net, o.rempel@pengutronix.de,
        stable@vger.kernel.org
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

On Mon, 15 May 2023 22:47:14 +0200 you wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> The control message provided by isotp support MSG_CMSG_COMPAT but
> blocked recvmsg() syscalls that have set this flag, i.e. on 32bit user
> space on 64 bit kernels.
> 
> Link: https://github.com/hartkopp/can-isotp/issues/59
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading from socket")
> Link: https://lore.kernel.org/20230505110308.81087-2-mkl@pengutronix.de
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net,1/9] can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag
    https://git.kernel.org/netdev/net/c/db2773d65b02
  - [net,2/9] can: j1939: recvmsg(): allow MSG_CMSG_COMPAT flag
    https://git.kernel.org/netdev/net/c/1db080cbdbab
  - [net,3/9] can: dev: fix missing CAN XL support in can_put_echo_skb()
    https://git.kernel.org/netdev/net/c/6bffdc38f993
  - [net,4/9] can: CAN_BXCAN should depend on ARCH_STM32
    https://git.kernel.org/netdev/net/c/4920bded3ee0
  - [net,5/9] dt-bindings: net: can: add "st,can-secondary" property
    https://git.kernel.org/netdev/net/c/caf78f0f4919
  - [net,6/9] ARM: dts: stm32f429: put can2 in secondary mode
    https://git.kernel.org/netdev/net/c/6b443faa313c
  - [net,7/9] ARM: dts: stm32: add pin map for CAN controller on stm32f7
    https://git.kernel.org/netdev/net/c/011644249686
  - [net,8/9] can: bxcan: add support for single peripheral configuration
    https://git.kernel.org/netdev/net/c/85a79b971164
  - [net,9/9] ARM: dts: stm32: add CAN support on stm32f746
    https://git.kernel.org/netdev/net/c/0920ccdf41e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



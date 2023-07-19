Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F6C758B2C
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 04:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjGSCKk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 22:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSCKj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 22:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECE71FD7
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 19:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BBCC616B7
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 02:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AAA2C433D9;
        Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689732622;
        bh=96Jt0TgXaRl/IuSMTNAabE3RdEAC0ecOVXMrdPNO4NA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kt9G1RN3zRDgO+YWxDqLM3WVtmAxIIsCi6VA42DwfwSADCJ7yGuE8ldBixU3kk+5w
         4FpYt4okJB7gwYssv6NF9PdK4EwdQQMJi30d3S7dERMqudNU8G5SwmTDv0cvyqpCHC
         J87j5Fp4PDgNfQGKexv4wbia6GBLKQMtj63zDem8P6RD6k7VWA1apnJOgdGW8JUV5j
         9me6dAiZ9YEHsdOwqAZRPklrbsPCxHtpkv5y4E8Ivl0n7A77CipbV4Ob6nfhrT5JMm
         AtO4ZuSwTUcYjbRKhAc8AsRLweMVUrIgxfR8zOY3d24XT0AFU8ctzpufVwZbnq2P8V
         6+gpnj84fSGFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F06CC64458;
        Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: can: Remove interrupt
 properties for MCAN
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168973262231.24960.391251104381339496.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 02:10:22 +0000
References: <20230717182229.250565-2-mkl@pengutronix.de>
In-Reply-To: <20230717182229.250565-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de, jm@ti.com,
        tony@atomide.com, conor.dooley@microchip.com,
        krzysztof.kozlowski@linaro.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 20:22:22 +0200 you wrote:
> From: Judith Mendez <jm@ti.com>
> 
> On AM62x SoC, MCANs on MCU domain do not have hardware interrupt
> routed to A53 Linux, instead they will use software interrupt by
> timer polling.
> 
> To enable timer polling method, interrupts should be
> optional so remove interrupts property from required section and
> add an example for MCAN node with timer polling enabled.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] dt-bindings: net: can: Remove interrupt properties for MCAN
    (no matching commit)
  - [net-next,2/8] can: m_can: Add hrtimer to generate software interrupt
    (no matching commit)
  - [net-next,3/8] can: ems_pci: Remove unnecessary (void *) conversions
    https://git.kernel.org/netdev/net-next/c/9235e3bcc613
  - [net-next,4/8] can: Explicitly include correct DT includes
    (no matching commit)
  - [net-next,5/8] dt-bindings: can: xilinx_can: Add reset description
    (no matching commit)
  - [net-next,6/8] can: xilinx_can: Add support for controller reset
    (no matching commit)
  - [net-next,7/8] can: kvaser_pciefd: Move hardware specific constants and functions into a driver_data struct
    (no matching commit)
  - [net-next,8/8] can: kvaser_pciefd: Add support for new Kvaser pciefd devices
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



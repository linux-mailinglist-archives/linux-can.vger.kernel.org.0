Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19473766807
	for <lists+linux-can@lfdr.de>; Fri, 28 Jul 2023 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjG1JAs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jul 2023 05:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjG1JAa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2023 05:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10980E69
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 02:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A36C062085
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 09:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A33AC433BA;
        Fri, 28 Jul 2023 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690534828;
        bh=mLpngb7akQU87GvUf3SL9kQ79C0M3C/MKJmScvSjsGw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YxV4m6GgFraadxSJFef1641KBsho6N0sGdeaxpzWQxXXnVPSICMsc3x0JTkfAQDQY
         CO+D9jZ6ETy0jvpfFqu/NZCCSkNEBbJobzuJDMXL2FrfO1Td94QFz+CVAHEiuqmHLn
         adSRpqYyGZYEFy9gOnOSeWmZLd09PD7a/Qf11PKOkSpqabuA56qYugz1iavFLJuejN
         1+vR6GYv/3koLOQrd2hn6aGY8r+dLsgMJ3wTGArHoTXQKoeRFD04BbpvZQQCXaQCU0
         +xFPpdHYNSt28W4ghLN/2yhVlHJ3eFsg+cqkrm3L8rdGCHYfMxvqM6D4zsQixOu0tF
         TF439yryHSXWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCB62C4166F;
        Fri, 28 Jul 2023 09:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/21] dt-bindings: net: can: Add support for
 Allwinner D1 CAN controller
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169053482789.22021.18149447145011642375.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 09:00:27 +0000
References: <20230728075614.1014117-2-mkl@pengutronix.de>
In-Reply-To: <20230728075614.1014117-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        contact@jookia.org, krzysztof.kozlowski@linaro.org
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

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 28 Jul 2023 09:55:54 +0200 you wrote:
> From: John Watts <contact@jookia.org>
> 
> The Allwinner D1 has two CAN controllers, both a variant of the R40
> controller. Unfortunately the registers for the D1 controllers are
> moved around enough to be incompatible and require a new compatible.
> 
> Introduce the "allwinner,sun20i-d1-can" compatible to support this.
> 
> [...]

Here is the summary with links:
  - [net-next,01/21] dt-bindings: net: can: Add support for Allwinner D1 CAN controller
    https://git.kernel.org/netdev/net-next/c/8c07fb0d6477
  - [net-next,02/21] riscv: dts: allwinner: d1: Add CAN controller nodes
    https://git.kernel.org/netdev/net-next/c/6ea1ad888f59
  - [net-next,03/21] can: sun4i_can: Add acceptance register quirk
    https://git.kernel.org/netdev/net-next/c/8cda0c6dfd42
  - [net-next,04/21] MAINTAINERS: Add myself as maintainer of the ems_pci.c driver
    https://git.kernel.org/netdev/net-next/c/e58ee933c27a
  - [net-next,05/21] can: sun4i_can: Add support for the Allwinner D1
    https://git.kernel.org/netdev/net-next/c/8abb95250ae6
  - [net-next,06/21] can: peak_usb: remove unused/legacy peak_usb_netif_rx() function
    https://git.kernel.org/netdev/net-next/c/74dedbd74d2b
  - [net-next,07/21] can: Explicitly include correct DT includes, part 2
    https://git.kernel.org/netdev/net-next/c/07382e6b68a7
  - [net-next,08/21] can: gs_usb: remove leading space from goto labels
    https://git.kernel.org/netdev/net-next/c/f1a14714bf48
  - [net-next,09/21] can: gs_usb: gs_usb_probe(): align block comment
    https://git.kernel.org/netdev/net-next/c/5780148bedd6
  - [net-next,10/21] can: gs_usb: gs_usb_set_timestamp(): remove return statements form void function
    https://git.kernel.org/netdev/net-next/c/a2002f455c0e
  - [net-next,11/21] can: gs_usb: uniformly use "parent" as variable name for struct gs_usb
    https://git.kernel.org/netdev/net-next/c/b6980ad3a90c
  - [net-next,12/21] can: gs_usb: gs_usb_receive_bulk_callback(): make use of netdev
    https://git.kernel.org/netdev/net-next/c/fcb880ef2f55
  - [net-next,13/21] can: gs_usb: gs_usb_receive_bulk_callback(): make use of stats
    https://git.kernel.org/netdev/net-next/c/55ad95d94425
  - [net-next,14/21] can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM
    https://git.kernel.org/netdev/net-next/c/6c8bc15f02b8
  - [net-next,15/21] can: gs_usb: gs_can_start_xmit(), gs_can_open(): clean up printouts in error path
    https://git.kernel.org/netdev/net-next/c/1494ffe4cbe0
  - [net-next,16/21] can: gs_usb: gs_can_close(): don't complain about failed device reset during ndo_stop
    https://git.kernel.org/netdev/net-next/c/5c6c313acdfc
  - [net-next,17/21] can: gs_usb: gs_destroy_candev(): remove not needed usb_kill_anchored_urbs()
    https://git.kernel.org/netdev/net-next/c/5391e0cbae02
  - [net-next,18/21] can: gs_usb: gs_usb_disconnect(): remove not needed usb_kill_anchored_urbs()
    https://git.kernel.org/netdev/net-next/c/d4cfb83d566c
  - [net-next,19/21] can: rx-offload: rename rx_offload_get_echo_skb() -> can_rx_offload_get_echo_skb_queue_timestamp()
    https://git.kernel.org/netdev/net-next/c/2e3df4a3b317
  - [net-next,20/21] can: rx-offload: add can_rx_offload_get_echo_skb_queue_tail()
    https://git.kernel.org/netdev/net-next/c/8e0e2950c9ef
  - [net-next,21/21] can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception
    https://git.kernel.org/netdev/net-next/c/24bc41b45583

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



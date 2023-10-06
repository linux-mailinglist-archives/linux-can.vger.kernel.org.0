Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB67BC27F
	for <lists+linux-can@lfdr.de>; Sat,  7 Oct 2023 00:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjJFWue (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Oct 2023 18:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjJFWud (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Oct 2023 18:50:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8349C
        for <linux-can@vger.kernel.org>; Fri,  6 Oct 2023 15:50:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4A7CC433C7;
        Fri,  6 Oct 2023 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632631;
        bh=1W7LbC0VrmW+4Ij5Fwh4nvGR2N+V+ItCCtOVdUA66Ek=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D3EbFBXy+9YePGzyXBvrgCKxhgku/zgz5yR7nLP+OgJowhFn7mLTfMgj7xxkjw+6l
         w233DVg/yMbhdgfUh22CW6B3vJ0moOvzYYA4e+0qvkBEnnLgNCEbNpJLyPxyrvf7Q0
         7zADh6AGdhBEhZaF191RA7qRTAI1gJblgFlqM/7RA3qD6Ru6JtQB+oq3/OnQpyNkOs
         gR04lz9SVunsMp2O8W29AVN+r9foMZFasyMpBaFIOg1swBEOAVdMfpXTQD5UgI9sJl
         xl8AQLtyDZCbbWf3R6nBguYF7h5f8TVRVWMqmnrmE0juWX1I6+LdUPd7ud0VOYGlXZ
         RwHvsY0boni/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8FEAC595CB;
        Fri,  6 Oct 2023 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/37] can: sja1000: Fix comment
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169663263167.25368.18212634780361201001.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 22:50:31 +0000
References: <20231005195812.549776-2-mkl@pengutronix.de>
In-Reply-To: <20231005195812.549776-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        miquel.raynal@bootlin.com, horms@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu,  5 Oct 2023 21:57:36 +0200 you wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> There is likely a copy-paste error here, as the exact same comment
> appears below in this function, one time calling set_reset_mode(), the
> other set_normal_mode().
> 
> Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/all/20230922155130.592187-1-miquel.raynal@bootlin.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,01/37] can: sja1000: Fix comment
    https://git.kernel.org/netdev/net-next/c/e36c56bf77d5
  - [net-next,02/37] can: etas_es58x: rework the version check logic to silence -Wformat-truncation
    https://git.kernel.org/netdev/net-next/c/107e6f6fe6f3
  - [net-next,03/37] can: etas_es58x: add missing a blank line after declaration
    https://git.kernel.org/netdev/net-next/c/4f8005092caf
  - [net-next,04/37] can: raw: Remove NULL check before dev_{put, hold}
    https://git.kernel.org/netdev/net-next/c/dd8bb80308c4
  - [net-next,05/37] can: peak_pci: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/3b9333493b5f
  - [net-next,06/37] can: dev: can_restart(): don't crash kernel if carrier is OK
    https://git.kernel.org/netdev/net-next/c/fe5c9940dfd8
  - [net-next,07/37] can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()
    https://git.kernel.org/netdev/net-next/c/6841cab8c450
  - [net-next,08/37] can: dev: can_restart(): reverse logic to remove need for goto
    https://git.kernel.org/netdev/net-next/c/8f3ec204d340
  - [net-next,09/37] can: dev: can_restart(): move debug message and stats after successful restart
    https://git.kernel.org/netdev/net-next/c/f0e0c809c0be
  - [net-next,10/37] can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds
    https://git.kernel.org/netdev/net-next/c/6411959c10fe
  - [net-next,11/37] can: dev: add can_state_get_by_berr_counter() to return the CAN state based on the current error counters
    https://git.kernel.org/netdev/net-next/c/9beebc2b5d00
  - [net-next,12/37] can: at91_can: use a consistent indention
    https://git.kernel.org/netdev/net-next/c/e26ccc4658c1
  - [net-next,13/37] can: at91_can: at91_irq_tx(): remove one level of indention
    https://git.kernel.org/netdev/net-next/c/18c987147483
  - [net-next,14/37] can: at91_can: BR register: convert to FIELD_PREP()
    https://git.kernel.org/netdev/net-next/c/bd7854e83900
  - [net-next,15/37] can: at91_can: ECR register: convert to FIELD_GET()
    https://git.kernel.org/netdev/net-next/c/abe1348753b3
  - [net-next,16/37] can: at91_can: MMR registers: convert to FIELD_PREP()
    https://git.kernel.org/netdev/net-next/c/53558ac133c0
  - [net-next,17/37] can: at91_can: MID registers: convert access to FIELD_PREP(), FIELD_GET()
    https://git.kernel.org/netdev/net-next/c/90aa9a250cf2
  - [net-next,18/37] can: at91_can: MSR Register: convert to FIELD_PREP()
    https://git.kernel.org/netdev/net-next/c/bdfff1433cd6
  - [net-next,19/37] can: at91_can: MCR Register: convert to FIELD_PREP()
    https://git.kernel.org/netdev/net-next/c/5e9c5bcc017d
  - [net-next,20/37] can: at91_can: add more register definitions
    https://git.kernel.org/netdev/net-next/c/63446dc70316
  - [net-next,21/37] can: at91_can: at91_setup_mailboxes(): update comments
    https://git.kernel.org/netdev/net-next/c/2b08e5217a1d
  - [net-next,22/37] can: at91_can: rename struct at91_priv::{tx_next,tx_echo} to {tx_head,tx_tail}
    https://git.kernel.org/netdev/net-next/c/2f1a01a82fca
  - [net-next,23/37] can: at91_can: at91_set_bittiming(): demote register output to debug level
    https://git.kernel.org/netdev/net-next/c/ccd7cd07051f
  - [net-next,24/37] can: at91_can: at91_chip_start(): don't disable IRQs twice
    https://git.kernel.org/netdev/net-next/c/8227088cb3c2
  - [net-next,25/37] can: at91_can: at91_open(): forward request_irq()'s return value in case or an error
    https://git.kernel.org/netdev/net-next/c/99f4ff41bbb0
  - [net-next,26/37] can: at91_can: add CAN transceiver support
    https://git.kernel.org/netdev/net-next/c/3ecc09856afb
  - [net-next,27/37] can: at91_can: at91_poll_err(): fold in at91_poll_err_frame()
    https://git.kernel.org/netdev/net-next/c/864c6f07d3c4
  - [net-next,28/37] can: at91_can: at91_poll_err(): increase stats even if no quota left or OOM
    https://git.kernel.org/netdev/net-next/c/aa3f5d935cbb
  - [net-next,29/37] can: at91_can: at91_irq_err_frame(): call directly from IRQ handler
    https://git.kernel.org/netdev/net-next/c/d3f4cf05402b
  - [net-next,30/37] can: at91_can: at91_irq_err_frame(): move next to at91_irq_err()
    https://git.kernel.org/netdev/net-next/c/e0c9db91d60b
  - [net-next,31/37] can: at91_can: at91_irq_err(): rename to at91_irq_err_line()
    https://git.kernel.org/netdev/net-next/c/efad777c3e97
  - [net-next,32/37] can: at91_can: at91_irq_err_line(): make use of can_state_get_by_berr_counter()
    https://git.kernel.org/netdev/net-next/c/910f179aa0de
  - [net-next,33/37] can: at91_can: at91_irq_err_line(): take reg_sr into account for bus off
    https://git.kernel.org/netdev/net-next/c/f13e86993d85
  - [net-next,34/37] can: at91_can: at91_irq_err_line(): make use of can_change_state() and can_bus_off()
    https://git.kernel.org/netdev/net-next/c/9df2faf947bc
  - [net-next,35/37] can: at91_can: at91_irq_err_line(): send error counters with state change
    https://git.kernel.org/netdev/net-next/c/3db6154e44db
  - [net-next,36/37] can: at91_can: at91_alloc_can_err_skb() introduce new function
    https://git.kernel.org/netdev/net-next/c/dd94a2f1f2f8
  - [net-next,37/37] can: at91_can: switch to rx-offload implementation
    https://git.kernel.org/netdev/net-next/c/137f59d5dab4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6597976FB5C
	for <lists+linux-can@lfdr.de>; Fri,  4 Aug 2023 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjHDHu0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Aug 2023 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHDHuZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Aug 2023 03:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A66421E
        for <linux-can@vger.kernel.org>; Fri,  4 Aug 2023 00:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D5C61F5A
        for <linux-can@vger.kernel.org>; Fri,  4 Aug 2023 07:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61747C433C9;
        Fri,  4 Aug 2023 07:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691135423;
        bh=OH3gniLFnPYrsPir9qBAOn8UQ6Wk+SDu8xHH9xs5YNE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mxBIU+xf7MQLWpD13qDK8PrbNkDuHRAQDJJbyj/VMv0eajyIrF0uE8n5GN/LkFpGG
         KMXUw0CndD295pjg+2sI2JPNPM5mpxYlLv+PoPM0aAahOk0bhli35H9dwucCovkVBT
         SjtSs+xGz0X7hw4sqoaaJpnb8vujDEZjZE7DNoVpeTyJEYCpoR3ZDcUJVnqy5VPc7H
         BRxRpof3Xvp9ldrbrRe1OMyhNhIXvWeoOmP5rS0M0NEC0TF7Qk7kknfonmZSdQe1Xe
         5e5yjVV6f0l4pW6SLV7p55XFuBGQawirlRUtad3rX+RD5FUuY7lxy8eBFWrUlrpFJe
         aZqK2yEhyZEUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C6A0C41620;
        Fri,  4 Aug 2023 07:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/9] can: flexcan: fix the return value handle for
 platform_get_irq()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169113542324.10721.6590687568774577784.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Aug 2023 07:50:23 +0000
References: <20230803080830.1386442-2-mkl@pengutronix.de>
In-Reply-To: <20230803080830.1386442-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        ruanjinjie@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu,  3 Aug 2023 10:08:22 +0200 you wrote:
> From: Ruan Jinjie <ruanjinjie@huawei.com>
> 
> There is no possible for platform_get_irq() to return 0
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Link: https://lore.kernel.org/all/20230731075252.359965-1-ruanjinjie@huawei.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] can: flexcan: fix the return value handle for platform_get_irq()
    https://git.kernel.org/netdev/net-next/c/53b8d2be4d71
  - [net-next,2/9] dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
    https://git.kernel.org/netdev/net-next/c/e332873dc7e2
  - [net-next,3/9] can: tcan4x5x: Remove reserved register 0x814 from writable table
    https://git.kernel.org/netdev/net-next/c/fbe534f7bf21
  - [net-next,4/9] can: tcan4x5x: Check size of mram configuration
    https://git.kernel.org/netdev/net-next/c/c1b17ea7dd7c
  - [net-next,5/9] can: tcan4x5x: Rename ID registers to match datasheet
    https://git.kernel.org/netdev/net-next/c/0d6f3b25ac2f
  - [net-next,6/9] can: tcan4x5x: Add support for tcan4552/4553
    https://git.kernel.org/netdev/net-next/c/142c6dc6d9d7
  - [net-next,7/9] can: tcan4x5x: Add error messages in probe
    https://git.kernel.org/netdev/net-next/c/35e7aaab3e00
  - [net-next,8/9] can: c_can: Do not check for 0 return after calling platform_get_irq()
    https://git.kernel.org/netdev/net-next/c/db31e6f170f3
  - [net-next,9/9] can: esd_usb: Add support for esd CAN-USB/3
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



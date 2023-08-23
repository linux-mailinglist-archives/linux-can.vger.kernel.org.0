Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B751784DCF
	for <lists+linux-can@lfdr.de>; Wed, 23 Aug 2023 02:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjHWAa1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Aug 2023 20:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjHWAa1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Aug 2023 20:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BDBCE8
        for <linux-can@vger.kernel.org>; Tue, 22 Aug 2023 17:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A521611BB
        for <linux-can@vger.kernel.org>; Wed, 23 Aug 2023 00:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE44BC433CA;
        Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692750624;
        bh=TSv4HzbZf9yJGHYModJaor4znzl4kLAnhhPpxAu5xQI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TIia88ID3IefAFBCrve7PaWhZ1s9/NMTffgU4WqRQxD+ovHAqSZczevAvn9mDSnzE
         wwQQRhKLQyxOHFJVTk/Iur1Uh0TpYbDhJCEQmlFdIn6HxXI6EawjyY2Vst/VeSuYYE
         1h86JVh05gMqT8FWiE8FgrajY/K9oAAvXlz8Pkzr/1uGabb3AHkAtn4ePbhxSsFuZB
         yedrSniTK4mI/kbVMFplxp+qIf5tkefbBZNQ/v8fD4KZ6s6NyI7qCYGU1KXaibIj2D
         4ZbMjI1+zXcWfeKP8/oFgnLQn+zVwIgvFztCoQ3Wye4rpK1jj0sTp19Q/Z15a5zpbJ
         +79ChDD6BvSxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C704E21EDC;
        Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [NET 0/2] CAN fixes for 6.5-rc7
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169275062457.22438.1864998736721387025.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 00:30:24 +0000
References: <20230821144547.6658-1-socketcan@hartkopp.net>
In-Reply-To: <20230821144547.6658-1-socketcan@hartkopp.net>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
        edumazet@google.com, mkl@pengutronix.de
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 16:45:45 +0200 you wrote:
> Hello Jakub,
> 
> as Marc is probably on vacation I send these two fixes directly to the netdev
> mailing list to hopefully get them into the current 6.5 cycle.
> 
> The isotp fix removes an unnecessary check which leads to delays and/or a wrong
> error notification.
> 
> [...]

Here is the summary with links:
  - [NET,1/2] can: isotp: fix support for transmission of SF without flow control
    https://git.kernel.org/netdev/net/c/0bfe71159230
  - [NET,2/2] can: raw: add missing refcount for memory leak fix
    https://git.kernel.org/netdev/net/c/c275a176e4b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



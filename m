Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D84781D7E
	for <lists+linux-can@lfdr.de>; Sun, 20 Aug 2023 12:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjHTKwq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 20 Aug 2023 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjHTKwo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 20 Aug 2023 06:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F9B1721
        for <linux-can@vger.kernel.org>; Sun, 20 Aug 2023 03:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E65A6611ED
        for <linux-can@vger.kernel.org>; Sun, 20 Aug 2023 10:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43457C433C8;
        Sun, 20 Aug 2023 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692528566;
        bh=mYe2B6ProoHh6yOHHOx2JZy5iEPQhOKFjnSX3vpZUQ0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S4jvEcwzSZ6csj27kZq8pjxDJfz+FGUYxa8XsKhx3YYywZ2NiISLJDjhD42eT0nob
         QeWARjcxcUVoWDpB4h5OoKCa09b7c7jAFXj5SmiS1vNmesxqkQ9H9pP8YPgbeFuz1I
         GnMsggVf/lgd8FmCNiag7YDNdGBI5BbqvwiACrdgdjsGtQxUxfgEJtXlmPHkpf/6Uk
         CICLIGNUUr3fpEuxnMvT6Bou1zUOHZ+Fat1G1oGAtEhiTGfmSepj8gVPMPfDv2pfsd
         s4MB71Q3G/KWNh25sFoL6mAsSHU8Cg0IPTV+gBTU81ooI+JgpuYWiHMlDBsOGHTYnI
         IWDEvAmBrWfKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C048E26D33;
        Sun, 20 Aug 2023 10:49:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: validate veth and vxcan peer ifindexes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169252856617.3170.10068041656079656903.git-patchwork-notify@kernel.org>
Date:   Sun, 20 Aug 2023 10:49:26 +0000
References: <20230819012602.239550-1-kuba@kernel.org>
In-Reply-To: <20230819012602.239550-1-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com,
        syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com,
        wg@grandegger.com, mkl@pengutronix.de, idosch@nvidia.com,
        lucien.xin@gmail.com, xemul@parallels.com, socketcan@hartkopp.net,
        linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 18:26:02 -0700 you wrote:
> veth and vxcan need to make sure the ifindexes of the peer
> are not negative, core does not validate this.
> 
> Using iproute2 with user-space-level checking removed:
> 
> Before:
> 
> [...]

Here is the summary with links:
  - [net] net: validate veth and vxcan peer ifindexes
    https://git.kernel.org/netdev/net/c/f534f6581ec0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



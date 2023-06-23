Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325AC73AEF3
	for <lists+linux-can@lfdr.de>; Fri, 23 Jun 2023 05:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjFWDKx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 23:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjFWDKk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 23:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA9B2727;
        Thu, 22 Jun 2023 20:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D3A61953;
        Fri, 23 Jun 2023 03:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 767B9C433CD;
        Fri, 23 Jun 2023 03:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687489821;
        bh=iaaUecfmjsyxg1Xzi58aBuLGBUafPHjOTk7jbDJm+as=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Lefg7V6ja/xfjLwlV0+KupLDjkVgELyTJH2SSntVUryfymZJ8OJZFYF+5SXSyzPpA
         970lPkmeWdz6XIS0QsRo16AzTMRmp+SAcTpOuTmjcqmVHpUkwE+MPuTaL/ebG78U7q
         HM2sGDcWENJF5TRRL+GHqLXFioIN4bD0uQtTXQx7wDY1QT+QKa08QrUZmng4Yz2OHl
         auUlvVNfnoYjCQf2tXTgrWEXQY8r6P2m0CW4cGykpcZ9nxzGwnuepERI0uLocbTnbW
         /klR2FJYqUzQUtT1ewt35Sr/6l8d11nhVSVRPwUT2R8H/A768VQh7qjPJ1DYUjOqTX
         2Lqs4EKuY3t+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 598F7C395FF;
        Fri, 23 Jun 2023 03:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: isotp: isotp_sendmsg(): fix return error fix on TX
 path
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168748982135.10729.12075135784970212786.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 03:10:21 +0000
References: <20230622090122.574506-2-mkl@pengutronix.de>
In-Reply-To: <20230622090122.574506-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        socketcan@hartkopp.net, carsten.schmidt-achim@t-online.de,
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

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 22 Jun 2023 11:01:22 +0200 you wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> With commit d674a8f123b4 ("can: isotp: isotp_sendmsg(): fix return
> error on FC timeout on TX path") the missing correct return value in
> the case of a protocol error was introduced.
> 
> But the way the error value has been read and sent to the user space
> does not follow the common scheme to clear the error after reading
> which is provided by the sock_error() function. This leads to an error
> report at the following write() attempt although everything should be
> working.
> 
> [...]

Here is the summary with links:
  - [net] can: isotp: isotp_sendmsg(): fix return error fix on TX path
    https://git.kernel.org/netdev/net/c/e38910c0072b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



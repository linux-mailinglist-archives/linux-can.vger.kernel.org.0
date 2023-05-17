Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D380705E8F
	for <lists+linux-can@lfdr.de>; Wed, 17 May 2023 06:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjEQEK2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 May 2023 00:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQEK1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 May 2023 00:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F16E77
        for <linux-can@vger.kernel.org>; Tue, 16 May 2023 21:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0D163FB3
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 04:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35F57C4339C;
        Wed, 17 May 2023 04:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684296625;
        bh=2Ie5qgPnmjg9LBGdKYRBsds730ggzbKFm717fhJBlrM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KsFePGDFZ8/JszCYfRJQHc8RGRRXnfMZVdjjZ2BKeptm5eTD5sPexjsXBAdfxmbaM
         E97eigvWh/rg/FU1UxtXiBJwxSuMbuyCxYsjNhEbEhoeK+vXpKu5pdQXIWA361jpSk
         lYKaRpq2P2DZC/1qAqUHMRZhduSDgU23Ziqr0ZD86BXv2piKMqwmDsIRtlREXhJvKu
         KXuHI7EHp0UAprYDTN/QMC9UdrQJLCnwTeNMDnkSPBJA2MjRDwGD7d/ADrwCMK7QJk
         Nd2p20baWp9zTlnFwafACgw+nxoiklPxTMuqXhj2Z8VyB7ypmmiD+BcMkxxdppYvEx
         8QcgEPbW+0UZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18CA3C41672;
        Wed, 17 May 2023 04:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/22] can: at91_can: Convert to platform remove
 callback returning void
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168429662509.29208.6237162430769044679.git-patchwork-notify@kernel.org>
Date:   Wed, 17 May 2023 04:10:25 +0000
References: <20230515205759.1003118-2-mkl@pengutronix.de>
In-Reply-To: <20230515205759.1003118-2-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        u.kleine-koenig@pengutronix.de, claudiu.beznea@microchip.com
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

On Mon, 15 May 2023 22:57:38 +0200 you wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart from
> emitting a warning) and this typically results in resource leaks. To improve
> here there is a quest to make the remove callback return void. In the first
> step of this quest all drivers are converted to .remove_new() which already
> returns void. Eventually after all drivers are converted, .remove_new() is
> renamed to .remove().
> 
> [...]

Here is the summary with links:
  - [net-next,01/22] can: at91_can: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/03ef5a4b322f
  - [net-next,02/22] can: bxcan: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/cba8ed7f0043
  - [net-next,03/22] can: c_can: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/1708caf4c47d
  - [net-next,04/22] can: usb: f81604: add Fintek F81604 support
    https://git.kernel.org/netdev/net-next/c/88da17436973
  - [net-next,05/22] can: cc770_isa: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/938100762293
  - [net-next,06/22] can: bxcan: Remove unnecessary print function dev_err()
    https://git.kernel.org/netdev/net-next/c/cca7d85ad80c
  - [net-next,07/22] can: cc770_platform: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/86eb8a19b477
  - [net-next,08/22] can: length: make header self contained
    https://git.kernel.org/netdev/net-next/c/6882011e8854
  - [net-next,09/22] can: ctucanfd: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/45413bf75919
  - [net-next,10/22] can: flexcan: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/55216590c9cf
  - [net-next,11/22] can: grcan: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/6aa62362f14d
  - [net-next,12/22] can: ifi_canfd: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/a5095a981018
  - [net-next,13/22] can: janz-ican3: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/3ac96f45aac6
  - [net-next,14/22] can: m_can: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/2d7c33d032ff
  - [net-next,15/22] can: mscan: mpc5xxx_can: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/36157299e67b
  - [net-next,16/22] can: rcar: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/ae08f87afff7
  - [net-next,17/22] can: sja1000_isa: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/0367b598afbe
  - [net-next,18/22] can: sja1000_platform: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/bc79adfbd1fd
  - [net-next,19/22] can: softing: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/737aec8a8f13
  - [net-next,20/22] can: sun4i_can: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/aaa278e646c0
  - [net-next,21/22] can: ti_hecc: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/9587b93b7755
  - [net-next,22/22] can: xilinx: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/0816e1dd5ea8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



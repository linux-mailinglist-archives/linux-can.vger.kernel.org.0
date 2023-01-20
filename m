Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E261674DD8
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 08:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjATHM5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Jan 2023 02:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjATHM4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2023 02:12:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A84347C;
        Thu, 19 Jan 2023 23:12:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BB19B81854;
        Fri, 20 Jan 2023 07:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781F6C433D2;
        Fri, 20 Jan 2023 07:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674198771;
        bh=UsDA/WXXNha7D3X3zm4UCLPWxcyELkZ9SDumqg8hpLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PS4AnRROOKLjgxLXubQPsnJZuVuMFSIwCaAv+ybwgIj3/XDtt/Yg/CiK7U6zIDXuJ
         mj3Bu3vKONgS7GReATPBTfS9JxFKERIoSVW6M9BbmdJLBL08BqJ2Au+/o7JA5q9s87
         eUlsouoYOMeqnvy9uIMyiZLQnUwkBDy1/VM78Q2PG9Q7m0DrWchHc+kRQqO4GX3Q12
         qTVy9bDWOik3JzbcYX6fzDHz7kMfO169im0PT6f6SbrFY+j9TlftBzCYrWxN80viKG
         3JHTkoboAdvpMtjhE2XCSlgWd+qm8ZnV13/C2+J4qdClAGh+VqoJuG7TjnVnxB3OtW
         FfLDJVJ3ZbmmQ==
Date:   Fri, 20 Jan 2023 12:42:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/2] phy: Add support for NXP TJR1443 CAN Transceiver
Message-ID: <Y8o+7iuWgYGtZshM@matsya>
References: <cover.1674037830.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674037830.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 18-01-23, 11:39, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> The NXP TJR1443 High-speed CAN transceiver with Sleep mode is a
> pin-compatible alternative for the TI TCAN1043.  Hence this patch series
> adds support for it to the existing TI TCAN1043 DT bindings and to the
> generic CAN Transceiver PHY driver.

Applied, thanks

-- 
~Vinod

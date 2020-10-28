Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF06529DEA1
	for <lists+linux-can@lfdr.de>; Thu, 29 Oct 2020 01:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgJ2AzN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 20:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731666AbgJ1WRk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590CC24684;
        Wed, 28 Oct 2020 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603875991;
        bh=rph1tfwjeUfkNdv+Xay3vP8t7dS/JiIJ7qk/l+QZ+Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IE92TK+RrVXe5Rvk7gXVLRlzcD1FcnKRqIql8GwA/dQP+2KYkbXAq/6TBWTu8t6KE
         /wx/6IgBPBgfuityI29Nwfo35dGkz5n7IDr3tGJfPnXoBmYMgiR4GR1BkX6L6sEdYx
         gOKEaQbQvNl0yL3AekYPGqg53XZibDhHvbqpx+/g=
Date:   Wed, 28 Oct 2020 17:06:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] arm64: dts: ls1028a: add missing CAN nodes
Message-ID: <20201028090624.GJ28755@dragon>
References: <20201001091131.30514-1-michael@walle.cc>
 <20201001091131.30514-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001091131.30514-3-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Oct 01, 2020 at 11:11:30AM +0200, Michael Walle wrote:
> The LS1028A has two FlexCAN controller. These are compatible with
> the ones from the LX2160A. Add the nodes.
> 
> The first controller was tested on the Kontron sl28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.

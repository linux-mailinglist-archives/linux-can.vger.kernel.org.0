Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0043DBDCA
	for <lists+linux-can@lfdr.de>; Fri, 30 Jul 2021 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhG3Rdn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 30 Jul 2021 13:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhG3Rdk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 30 Jul 2021 13:33:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6DAF60F5E;
        Fri, 30 Jul 2021 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627666415;
        bh=YRO6vWpfnU7icQPlHZNRBCu93eYY731ezHLMVpTf3Zc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zm0miPlCH9KoHtQigWYBElxqoT9BnU6d2fSLFVNJjwjSdV6bxYkgwCcSnFLsNCqbD
         nLY9qja6kx+2DMLIRau4HCA18NzvEKmjG7zM96jHEnyP4ZqPfj5LVuUjvbtZVkHpmu
         7bxulUSdTPiTsxm1h1np3qRygm/yuQP6pXQwzhYSA9Q7BYS+ab2d9meQQaqXBaXgSe
         ug7X3eDerH2gfbwKSa7KsdIHFqzrSWx+u2Spj1pMCfxgyDFdzmdHOjNh3B5D0bQRRE
         0GVjf8C4wC7UWE+va8yVUchyvn5GFGAcIrfpsvzMrrIYFGBmOiqp7gORJrJA6W7UgF
         xs8htW2d9hmsw==
Date:   Fri, 30 Jul 2021 10:33:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: pull-request: can 2021-07-30
Message-ID: <20210730103334.2570c9f5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210730070526.1699867-1-mkl@pengutronix.de>
References: <20210730070526.1699867-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 30 Jul 2021 09:05:20 +0200 Marc Kleine-Budde wrote:
> The first patch is by me and adds Yasushi SHOJI as a reviewer for the
> Microchip CAN BUS Analyzer Tool driver.
> 
> Dan Carpenter's patch fixes a signedness bug in the hi311x driver.
> 
> Pavel Skripkin provides 4 patches, the first targets the mcba_usb
> driver by adding the missing urb->transfer_dma initialization, which
> was broken in a previous commit. The last 3 patches fix a memory leak
> in the usb_8dev, ems_usb and esd_usb2 driver.

Pulled, thank you!

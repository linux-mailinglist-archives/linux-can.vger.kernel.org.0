Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982763A5C92
	for <lists+linux-can@lfdr.de>; Mon, 14 Jun 2021 07:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhFNFw7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Jun 2021 01:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhFNFw7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 14 Jun 2021 01:52:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05209611CE;
        Mon, 14 Jun 2021 05:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623649856;
        bh=KYwc30r/lp2B0B16drySkBiM9QvnXttHPWZWHoPBwVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4PVRON784Zn6cLN1rockSMpa0A0SGXEaqR1omCd31/X7EcQGJ+xrASwE08hVf1/e
         VOQiatwTdgQff82mQ/4lP+051oS1SZan8l9d4Ouba3sfhNDJcgqvoQCJc0+2SbDSWq
         ap4jCmG0mlTzURGwfmyn1HbNwrTK5j2og5ikbQKGtoxUdOvwT6laeebeSgSMhfM9l0
         9qx0/Ul37HSiBFK6ApP5f54rbhWUcQ16u6JR1T6Tk1RDb/RaISwc5mFDI3QfcUz8XK
         AqjLKZhp13Yqd9aUyCHAb7AW62XGH8xYM2jR09WiqU9A01nRl3EfZ3J5naYPpRdEjF
         0fjTVLUfODEog==
Date:   Mon, 14 Jun 2021 11:20:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Aswath Govindraju <a-govindraju@ti.com>, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] phy: core: Reword the comment specifying the
 units of max_link_rate to be Mbps
Message-ID: <YMbuPaSrBZ+W/uKN@vkoul-mobl>
References: <20210510051006.11393-1-a-govindraju@ti.com>
 <20210510051006.11393-2-a-govindraju@ti.com>
 <YLSNvUDJZ/v6NTuN@vkoul-mobl.Dlink>
 <615d3a2a-0dc2-0e87-fdac-e170542d33da@ti.com>
 <0150622f-8543-ac4a-fe18-f22d7862d163@ti.com>
 <7913b08e-a71c-d29d-d921-c25a87c0616a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7913b08e-a71c-d29d-d921-c25a87c0616a@ti.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 11-06-21, 18:31, Kishon Vijay Abraham I wrote:

> >>> So there are a few users of max_link_rate. It would be better that we
> >>> document all previous users of max_link_rate that unit is in Mbps and
> >>> then modify it here
> >>>
> >>
> >> I was able to see that the max_link_rate attribute was used at,
> >>
> >> drivers/phy/cadence/phy-cadence-torrent.c:2514:
> >> gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
> >>
> >> and in the bindings there is indication that the units to be used is Mbps.
> >>
> >> Can you please point me if there is any other place that I might have
> >> missed to look at or that might need documentation update?
> >>
> 
> The only user seems to be Torrent and max_bit_rate is documented well in
> Torrent.
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Series Applied, thanks

-- 
~Vinod

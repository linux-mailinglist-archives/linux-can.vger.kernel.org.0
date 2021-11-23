Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B2459C68
	for <lists+linux-can@lfdr.de>; Tue, 23 Nov 2021 07:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKWGs2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Nov 2021 01:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhKWGs1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 23 Nov 2021 01:48:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DE3760F45;
        Tue, 23 Nov 2021 06:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637649920;
        bh=peZWcZ5QzAiCu4/DFD2OrH+VwPz/oUU+/hf9z8zwbo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CeW0zFmLnXzu1wS3gRdj3/PzvQG9Lm3F2fta/BIXqluVtNzX+cDJT5axm00T7B7VV
         wCMxhrJr7hMJU/hDfH47LRRnm/0qiyz7jYUkYNJf5kChoHmCSqDGSxP3xX72+1prUR
         6j8hVfxqfZLjsAP3Zzw3h+P7j0AR1eeB+G+Jn7G8OpYcsyeAF3EY+WcOR+AX8itufF
         s6+oViumAD6lPzeRgTwtMUwhLKHetHy3EWC7QYyPGet/fcRW0xzUsM6iOwsWdesmu4
         WlSY0EJnxAyWwmio13YoYFP2PI2L4nYgSBzLntFR+shOUE8ch/xTL4P4+k+IDoFpu4
         PZ8th2JFsF7yA==
Date:   Tue, 23 Nov 2021 12:15:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: phy-can-transceiver: Make devm_gpiod_get optional
Message-ID: <YZyN+3e717rJ8Ktu@matsya>
References: <20211102112120.23637-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102112120.23637-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 02-11-21, 16:51, Aswath Govindraju wrote:
> In some cases the standby/enable gpio can be pulled low/high and would not
> be connected to a gpio. The current driver implementation will return an
> error in these cases. Therefore, make devm_gpiod_get optional.

Applied, thanks

-- 
~Vinod

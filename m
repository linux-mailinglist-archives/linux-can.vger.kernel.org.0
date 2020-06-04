Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43451EEABA
	for <lists+linux-can@lfdr.de>; Thu,  4 Jun 2020 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgFDS6S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Jun 2020 14:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbgFDS6P (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 4 Jun 2020 14:58:15 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64191206C3;
        Thu,  4 Jun 2020 18:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591297095;
        bh=f6SyfWm0wc5LAIl0L85mmf5BHNbNVTMvYK2Ad0cEaIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1wp6QRY/EAUj+SwlQvoCkg+5y9+eU2EEZ8UwzevBLo3seCHifSbTDwJbZPmLCXBBG
         Llw/ywQAlLzHHRIO2NutaxHWXKfeeo5am9eeu419E1EBPCgkGcGFrnWpPdLMDhAeKO
         87YnFab5Bvi2Zcnp+x/Ikq1cdr8p7dG45VdjYILA=
Date:   Thu, 4 Jun 2020 14:03:21 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: Replace zero-length array with flexible-array
Message-ID: <20200604190321.GE10051@embeddedor>
References: <20200507185118.GA14022@embeddedor>
 <0420f571-2d6a-c830-2029-8da60e3c2094@hartkopp.net>
 <73903bc6-afb7-f30e-28ef-065d41c6ace6@embeddedor.com>
 <74c08a71-afb5-aba4-2c30-c342b4a7e61f@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c08a71-afb5-aba4-2c30-c342b4a7e61f@hartkopp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Jun 04, 2020 at 08:31:55AM +0200, Oliver Hartkopp wrote:
> 
> Great! Thanks for the info - and how I could have checked it on my own, too.
> 

No problem. :)

Thanks
--
Gustavo

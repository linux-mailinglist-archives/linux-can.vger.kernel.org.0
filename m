Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E2C28A24B
	for <lists+linux-can@lfdr.de>; Sun, 11 Oct 2020 00:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgJJW4p (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 10 Oct 2020 18:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731118AbgJJTCW (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 10 Oct 2020 15:02:22 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F215223EA;
        Sat, 10 Oct 2020 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602347675;
        bh=rN2RVNvkUAajl+OFUK7Q+q3UkemoM0e27/OZT/UWqRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p2nOc3CrI/ySGmv5VclfiHMQUI59BfdVWFsAmzzM8H/fcJxNJU1p0feypnRy1Cv6/
         /doT4eoKwwrLh2i17XiiVMviLhdTrtdEPrCUeqzP6LHPWWhMKe89QCJbJi8pRgtO0+
         js3v4kxZpZQ+HrYvdZgmqhPvlxkPWODL8/CXQiGE=
Date:   Sat, 10 Oct 2020 09:34:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
        davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 08/17] can: add ISO 15765-2:2016 transport protocol
Message-ID: <20201010093433.7c11ef46@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <10c8b62c-e522-aaa4-2e75-d1c1bd630735@hartkopp.net>
References: <20201007213159.1959308-1-mkl@pengutronix.de>
        <20201007213159.1959308-9-mkl@pengutronix.de>
        <20201009175751.5c54097f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <bcebf26e-3cfb-c7aa-e7fc-4faa744b9c2f@hartkopp.net>
        <20201010084421.308645a2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <10c8b62c-e522-aaa4-2e75-d1c1bd630735@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, 10 Oct 2020 18:24:48 +0200 Oliver Hartkopp wrote:
> Ok. Understood.
> 
> I'll remove the default=y then. Would it be ok to add some text like
> 
> If you want to perfrom automotive vehicle diagnostic services (UDS), say 
> 'y'.

Most certainly, feel free to provide whatever description you reckon
will help users who need this to identify the option.

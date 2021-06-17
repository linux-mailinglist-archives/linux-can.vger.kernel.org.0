Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E692E3AB4D5
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhFQNgD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 09:36:03 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:38404 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhFQNgC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 09:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623936831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUTCbLDJ944g7guNYSUqiuktQNN0Iln97z6m+EaP/Ds=;
        b=wdCnxlXoLfTm6lyiUOd1gvkKqdQcP4QULzWHn+yCmAdXEaX/VKaYly3UmTPjhOe44QJwu/
        wc+udf6rXLaMf9drVCmDv4nrDruakQZ0amG+YGvBjq5xptsEO/lV+7AGXI0OBAGGX2nG6j
        bceFrUnrTHyPlpwFQWY5xe6/XQna4I8=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 72be8f16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Jun 2021 13:33:51 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] can: flexcan: add mcf5441x support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <20210616231652.738027-5-angelo@kernel-space.org>
 <20210617130053.yovl3b3p5mn2srnd@pengutronix.de>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <089ba61d-2b84-6f99-ab00-c7187d37bad3@kernel-space.org>
Date:   Thu, 17 Jun 2021 15:32:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210617130053.yovl3b3p5mn2srnd@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Mark,

thanks for the review, will fix all.


> regards,
> Marc
> 

Regards,
angelo

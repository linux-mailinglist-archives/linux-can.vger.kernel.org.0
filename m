Return-Path: <linux-can+bounces-1993-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC89C5AC8
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 15:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877C328407C
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352E41FF029;
	Tue, 12 Nov 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZikcAF5F"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095EC83A14;
	Tue, 12 Nov 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422768; cv=none; b=MYs/EktSD/AXT15yu/Ffwsbu72/an94LuBoZWBAX1nl20NC8Fz+xSq43UsFFERETleZeM5COsG0khEDfuCA/ghARjpien41MDy9CbA11fhL8TBIJ5XsFC859FtY69E/Hp5OXeiACmPtYxXjvMWkHlQoIwpgWY/m6hIotxWH4iyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422768; c=relaxed/simple;
	bh=LiEzYE5YhQqrv+RfGuvo4CDTDcIkTz63uEM7XySiVWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM97ScdbKlDi7WZWI+oGmbUBBGyavkEXLo1WteYhaPDeliZc9giLEtRiWFlsaJDATfoUFROmB87KEnMpZWj53n5kk6f8ZDDk0LAVS4iDtPu8c2YHnbZnyxbO5Uo0t/c9CZTmVGEgmC0JTiC41s5pV155QzdXOhdOxQc1z8lal7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZikcAF5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6328FC4CECD;
	Tue, 12 Nov 2024 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422767;
	bh=LiEzYE5YhQqrv+RfGuvo4CDTDcIkTz63uEM7XySiVWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZikcAF5F7z87EB8RqDg4be2FNvQCfot7kckTNd0g3mZiU1sB8/NHpNvA3OQr+1MmM
	 qGoDIw6qzbDdgQK7+DAacw3v8lN97SYiPy3h6I4/wVGqtxPveJsydZMqd6cwCC6hno
	 qZSoRa9CuTf53vSLhowwqo8+ljkZSWFZ3xjHg8EKADK/9r5Hs5A2iQc1fYlihrjspT
	 x3/sj8hj3N/n6YMr620nB4DS5HIhmk2RDuhL4XTh/JxuUNb8LkYfYEktKmQZDVzxiZ
	 ppBmpEk/b7lJvKDeHVQvJ+WqD2IU6n68RSrA+vxZfiBnKWDP8jvFGQNZD8RqZjljK/
	 /GxH4EjFWzjkw==
Date: Tue, 12 Nov 2024 14:46:03 +0000
From: Simon Horman <horms@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] can: m_can: add deinit callback
Message-ID: <20241112144603.GR4507@kernel.org>
References: <20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com>
 <20241111-tcan-standby-v1-1-f9337ebaceea@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-tcan-standby-v1-1-f9337ebaceea@geanix.com>

On Mon, Nov 11, 2024 at 11:51:23AM +0100, Sean Nyekjaer wrote:
> This is added in preparation for calling standby mode in the tcan4x5x
> driver or other users of m_can.
> For the tcan4x5x; If Vsup is 12V, standby mode will save 7-8mA, when
> the interface is down.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/net/can/m_can/m_can.c | 3 +++
>  drivers/net/can/m_can/m_can.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index a7b3bc439ae596527493a73d62b4b7a120ae4e49..a171ff860b7c6992846ae8d615640a40b623e0cb 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1756,6 +1756,9 @@ static void m_can_stop(struct net_device *dev)
>  
>  	/* set the state as STOPPED */
>  	cdev->can.state = CAN_STATE_STOPPED;
> +
> +	if (cdev->ops->deinit)
> +		cdev->ops->deinit(cdev);

Hi Sean,

Perhaps this implementation is in keeping with other m_can code, but
I am wondering if either the return value of the callback be returned to
the caller, or the return type of the callback be changed to void?

Similarly for calls to callbacks in in patch 3/3.

>  }
>  
>  static int m_can_close(struct net_device *dev)
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 92b2bd8628e6b31370f4accbc2e28f3b2257a71d..6206535341a22a68d7c5570f619e6c4d05e6fcf4 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -68,6 +68,7 @@ struct m_can_ops {
>  	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
>  			  const void *val, size_t val_count);
>  	int (*init)(struct m_can_classdev *cdev);
> +	int (*deinit)(struct m_can_classdev *cdev);
>  };
>  
>  struct m_can_tx_op {
> 
> -- 
> 2.46.2
> 
> 


Return-Path: <linux-can+bounces-6116-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 887FAD14A0B
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 18:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A63A3304D8CA
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3730F7F0;
	Mon, 12 Jan 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm3Xtq2g"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9326B2DA
	for <linux-can@vger.kernel.org>; Mon, 12 Jan 2026 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240259; cv=none; b=P5PrigkHLahuoAOYfQcNp1H3lGy5Bx6wxwTsMcb8NpOqksnkqP4ogEGB8FI40SWj8VhKvkCoGDjTllOgj3AGVMeLigSsIftNKhfi8WbzzKi0Ieyo7lYXot/TwborVPtaCLj/K+agoHqVb8yvwq6lH+krGdecLALJnJEuw68ddJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240259; c=relaxed/simple;
	bh=+VWjEfwDhryU8ObQ2/gfNetPisVn4j+sD6WRIehdzR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRU7NcE1rLV6HcNfD3cmVy9XQ1ercVuqQLie1bjOtk5qiaY0B4FvWF6djG4zm5Y3/BT6Sd9oKIBimFiVJgitmNEq2j+ePqqvkpVD6oncGC6kowXYLqe1Moc6o5nw+0mVmXUww1DZMZNN0n8XccXTJFhMM+S9rFQqT5vkQg4/Qwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm3Xtq2g; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0d6f647e2so66647445ad.1
        for <linux-can@vger.kernel.org>; Mon, 12 Jan 2026 09:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768240257; x=1768845057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piLUL2M8WMtGows0Q7lGhuaH4xf67uj9PmnQl3vr760=;
        b=Rm3Xtq2gay7wNALFjw5bYAEewyHoTTuGIB+pTTYVGAjiy/o4NFos1cCaQn7qHBzzfR
         gIr9VPSx0C+JKZ1RWuhr0Ple84LU4GE6SjLtEA6IFMl9WHP0RuK2rI8gJy6ZEtm1FGDf
         9OL9bowvDgRmkkfLLS3oyU2V9kFciaYE2dGtEHlhUlDc8u7Ufp62LZBMu/2aA+SUkj52
         SRVSvqsdjWaNZLqAbXR6q0/puQUUYt69sRFCYHBoUxL01otWgmTbD0VPbn3CcCkTx0Qy
         ZBNDtQ/bGuLP0buEs/gDrsRtOa2EUj56sTF3EPajAFmeEo31erdnejRV6JqZ8DBrajfo
         s0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240257; x=1768845057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=piLUL2M8WMtGows0Q7lGhuaH4xf67uj9PmnQl3vr760=;
        b=SkJfG5yE523FNhYve3+FErXIjxTeyBUTV8uz4Wzs8caflzvzHVca0/SYcqkM9OHJwd
         76PI6Ug0zWO4wFhTktcFrTZ2n1wKa6GKuNZXvj9eGfyMM1V29zoBhfwTNQERaH0y0wB1
         x2wgBS5puVmsGcUGZRDPMosJLZ6H8FeMKSKd9tO+1y3RXYQACB2VFARbZyBWvaWpRkWw
         rsnicTP3E9PbeVRPeOeJpIqUwDrS/AfMWncbHrg559oSM4aOI7N7Mll7pLeMJR+8xN2E
         Z8HAyrlnyvoptxnrT4V/xXxWItoMALPoBjEO+/UKTt4NN95f+2+tp+7cudZZRpqWfj+z
         3QMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW55StNUOdbIcIcle0Y2VFHEpS6T1pPRJ19nLwUfI/XKIP2nqZPOJQsF8EfZCuhjV3GbMAYqKwlfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcBVwjPm4Se1lX30is4igpYaOWilLpjSzgLB2NsPcRtqTbAzT
	+VVW2TleJmP0Qc0/d3bJy5yGTCzNqp6FsQkptjhFoPhevkCBAETOBwm/
X-Gm-Gg: AY/fxX6WFXmXMbqMYxm62wAxOqVj6J2U1+VisVDWNryVVxfDjLd3yp4yQ95yjrLFHFZ
	foH+QiOrNJv7j7uhFKZ6D1NLKcTxphgmjhdxwoqVbszY5qGNcv06gYshWuIfpmKiv/nkreVIa7x
	yhz9AolMHT058Ch4dRduYYliNBDfkSkcL0mfX1yh901QzjU+Jx+g1abrM70WEPg2ShFmdM2bdqf
	6+tnk0vSbWdOFjvOz7Ypz7Pg6L7YZWQEu86bVrPAiwrojmp5mtr0/wvO9r4Nih4uO/AAfn0Cblh
	2r3/tzn7AzxySjRQxa3HsL8IUS8ZjoiS8EPGDXdMP0JAFy/VxX5K9XNDACirdNmqf6fvHKWLcmJ
	91EwjAJLNy4LotejDGfC1y9VB62yeOyKzIcBCH152QD95rG+KYG33TiPvc8DreKrAGVHbfKuYUc
	EAR1MyIjyqNosUL9VVItF24zN6hlk=
X-Google-Smtp-Source: AGHT+IEk4xXPZRyodP5FSOXlD/IumhCAd7oJ19PiJjZ1roGS/dFYPtWdjiuAhErB6M4ZBAK7fFIgCA==
X-Received: by 2002:a17:903:9cf:b0:2a0:c1ed:d0d9 with SMTP id d9443c01a7336-2a3ee49b022mr168358015ad.46.1768240257133;
        Mon, 12 Jan 2026 09:50:57 -0800 (PST)
Received: from rakuram-MSI ([2405:201:d027:f096:5c52:f599:118c:bed2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a464sm178347915ad.2.2026.01.12.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:50:56 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: socketcan@hartkopp.net,
	rakuram.e96@gmail.com
Cc: corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH 2/2] docs: can: update SocketCAN documentation for CAN XL
Date: Mon, 12 Jan 2026 23:20:49 +0530
Message-ID: <20260112175049.10716-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: 20251231-can_doc_update_v1-v1-2-97aac5c20a35@gmail.com 
References: <20251231-can_doc_update_v1-v1-2-97aac5c20a35@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 31 Dec 2025 at 23:47, Rakuram Eswaran <rakuram.e96@gmail.com> wrote:
>
> Extend the SocketCAN documentation to cover CAN XL support, including
> the updated frame layout, MTU definitions, mixed-mode operation, and
> bitrate/XBTR configuration. The new text also explains how error
> signalling behaviour differs between CAN FD, CAN XL mixed-mode, and
> CAN-XL-only operation, as implemented in the current kernel stack.
>
> In addition, provide example iproute2 "ip" tool commands demonstrating
> how to configure CAN XL interfaces and corresponding bittiming
> attributes.
>
> These updates align the documentation with the behaviour of recent
> CAN XL implementations and help users and developers set up correct
> test environments.
>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
> Tested the documentation build with Sphinx; no errors or warnings.
>
> Used below command for testing:
>      make htmldocs SPHINX_WARNINGS_LOG=warnings.log
>
>  Documentation/networking/can.rst | 615 +++++++++++++++++++++++++++++++++------
>  1 file changed, 518 insertions(+), 97 deletions(-)
>

Hello Oliver,

Any feedback on this documentation update patch before sending v2?

Best Regards,
Rakuram


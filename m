Return-Path: <linux-can+bounces-5783-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914BBC9456A
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 18:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4DE3A6379
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FA523AB87;
	Sat, 29 Nov 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sGNMbO6T"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D4622B5AD
	for <linux-can@vger.kernel.org>; Sat, 29 Nov 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435811; cv=none; b=fPTq5EVdGyCihSjeJvaiNRx3d3xqAAcMvMMDWuWq6CNPucey56t+waOsvxHOjKk/jx6LxXSW8DmZxgLt4da1cVsZBGWuguPMEZpMrflnSTtC752Or8neKwL8pB46mBd15fGG+Gj+gyuxIQ2xHji4Cc1n243hYJEj8cb2MGDCpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435811; c=relaxed/simple;
	bh=UG6BImwAw0rc1V/PYQuBi08tBpQDy0BcQj18aGudhAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDDJygd8kBfUuiKsed0kQ104Cd2kTaTOr0fpuh3zM4DQnL/itOmidLpYJ8rYI163Z2uLkSRPfh2givccZjWbzTPH5efIC4ti/Hm5e9Xejnp7ahRNmtBrO819Fe8NkGyKH8RsnzM687b527BoFGE5oGlFcksFIAMw4Wcgjy7Nu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=sGNMbO6T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so18501195e9.0
        for <linux-can@vger.kernel.org>; Sat, 29 Nov 2025 09:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764435807; x=1765040607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3NL6lljZUIz80S32y8CRSrRW0oz1aLxnHtOot0GJL8=;
        b=sGNMbO6TC1zfTEnv9YZTlU8jCQMwJJOof4Y5aII5rOvEikVlxvRPRg3i4tunktHly/
         8C5cdHIf67TmcIqjyyHlsfGUXGOdIUVMa2V8M4ElJQFeaCWOgvl5Nmsw/hyXIDHAuPAg
         0x1tdXYhNDNAgS+CVJ8pHmwkrped1tAiaZdS7xnuRocNKBLR8aIV9mz2xMZwDdHhSDHC
         Hxgm2xolQkJx/mB3rG1K8Pt73YC4cTkcQJO2boDcadK6j6PoPhIR0ctQ4GcPwhJjuioV
         oZiKhgPcylo3JvZ5EBlNwGWipSoS0ADZuSfrKBPeV1Jf2XpaJrzdQDJ0iuSjIGfXUXAs
         8SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435807; x=1765040607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w3NL6lljZUIz80S32y8CRSrRW0oz1aLxnHtOot0GJL8=;
        b=oBljgzS/uwEKSA2qAcr7v67pvrO49qmP+0HsWAGRGCU+mfrUi616e8vyJWwLX/1S6j
         uCGgC4PFOjgeLLaJYHXgvgVJVW3qW8G6MzV3DFrFalS7peEMzgPUe62igYaqQRVB2YDy
         mrjeWGrHMuKLIcmGROgYDnvUfzN5rFSFDWcm0AotTlw0LCNKo10RMjMm7FZ82Pgt1AbO
         C8EZZHDczGntdH8azLCFHm3hFeDf6EP8Nxcdp0eN21+myXdPXh7E4Hp/Nc1FKTdMc0Xu
         uE6JOj766RTsoDeczFk+jKimG6qxvIfNh6o6x4Gs4FN+8M65iCmC1bJBp6Kk8As3JnKj
         Q/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV0x5hR1EvG3K5xLLA50d1Hfu7aIqh5ZV/DTuf0/gvPFFXX48hDtufkqmdMzGW410yhVvaqC+9mEgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjASHTDCcQC93+8W1jrQlZP5IJwr6vZi0DmQVPKZEU3QKRDgf
	l/ZE3iZWMev/iWk9NP4krGZk5vWaC2tUiE0+5wsGFJNk4Gk3vUYT+ApJrwkgAGv2pnQ=
X-Gm-Gg: ASbGncvxuK4JatMCCusODNLF1b/B8DsvKiqTwUId2xFvNUwjwmdvTMOM0uXTMyrdAhK
	gbOs8Y0sKOszsf7JKgOzAZzPlbZweDRTSYgA93YZlLPLYkeczNysUr31FgD6/0CQb+r9aftKnqS
	HCYcRwP1RkIFUVO2fQWtKB73Ii8NHT4TlZHEI06rWEvYFqkF87fayEMmACxcvLM2jD4v20zLcm+
	bJG3SIe2TAZd4ACBvITuh9dg5t3RjxwOV8syDL+2kIyj7RUvWRcL1uVARAb/41Gwvol9Ppw8DM3
	/ZMdjsQ+cvhscki5rWhMMUjdCxzKLk50ObHpJScztqgYFYHcrp8vBYF+tyu+lLmnHCgO3G2fdqH
	zS5Mpyz8oFCeaLI3243+18rX9QJhvME4ZVxNjfa6s2q2FXnm4H792csVsj84hxkheFM7Qqa10Qx
	MbPD5PVctUUUQc94RzJw9NndRJaxydWPRAGFYZL52v4CxN1aVLbm7ut69zorZImug=
X-Google-Smtp-Source: AGHT+IFMyGWGn1s47jdw8AjAdihGCO1Ca1kpb9N1dRAunGwTYi03BItPfZ0L/KhrSR6N1PNV/cWbNg==
X-Received: by 2002:a05:600c:5249:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-477c10c858bmr314859575e9.4.1764435806589;
        Sat, 29 Nov 2025 09:03:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca8e00fsm16251408f8f.34.2025.11.29.09.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:03:26 -0800 (PST)
Date: Sat, 29 Nov 2025 09:03:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver
 Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH 4/7] iplink_can: add the "restricted" option
Message-ID: <20251129090320.594aa81a@phoenix.local>
In-Reply-To: <20251129-canxl-netlink-v1-4-96f2c0c54011@kernel.org>
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
	<20251129-canxl-netlink-v1-4-96f2c0c54011@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Nov 2025 16:29:09 +0100
Vincent Mailhol <mailhol@kernel.org> wrote:

> @@ -257,6 +259,9 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>  				invarg("\"tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
>  					*argv);
>  			}
> +		} else if (matches(*argv, "restricted") == 0) {
> +			NEXT_ARG();
> +			set_ctrlmode("restricted", *argv, &cm, CAN_CTRLMODE_RESTRICTED);
>  		} else if (matches(*argv, "restart") == 0) {
>  			__u32 val = 1;

Good example of iproute2 has banned use of matches. Because usage like the
(think of what happens when user was previously using 'r')


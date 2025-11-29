Return-Path: <linux-can+bounces-5784-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986DC94570
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 18:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A023AC5AA
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98161FC0EF;
	Sat, 29 Nov 2025 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jAHcuCL7"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB522F177
	for <linux-can@vger.kernel.org>; Sat, 29 Nov 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435852; cv=none; b=YmEeRb3C4YWWWRmMfM5SU420/wv5+BsqlLUCJ26DxNfKCwN766VBkfqIbWTgO1FY9OXp1VNDHZZLYsze6T5h6igXaC6SSvgxbpg4mBQ/pdb0+agUIuuxr2URwLcNXc3aolGDNJ5dFSmKgwpHrml8K8hCNDrQcChHxiO9bQAke/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435852; c=relaxed/simple;
	bh=1ofg9EbWX3TxmwN9MuMZWoXX9LDX+R4phsPu3w2Jy7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUL79OogwQBBU109Esn7VvZ6VE0SmOwC/jpxt7nD7/5xIYXnjC21+nup5DWI2zAGJdcFGw6MsQDJgSe6Ijbaj32cVoYRj9L4XDoIoTs+BK48gHRJi8Z7c2OH7NM8i6qu/wITWXeW2pHR6g5ueRNkZo3QuY22Tf1EEbgDr8degKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jAHcuCL7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88054872394so37953336d6.1
        for <linux-can@vger.kernel.org>; Sat, 29 Nov 2025 09:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764435847; x=1765040647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0JrUY6rvuTDOtsRxKK87/+s+sI+ekupf3sIqBsYK/M=;
        b=jAHcuCL7uwpZnl40rR2bXPZRfEbNhO7WD6ASwTW58LSD05Lhk+gOiwKWSThKUsCpq8
         OOgStgmS42YMV1t6dPSJ5I7khNpvx96odfvOJOOj6Rs9HWlBQtJdh1oM5DvZTwgkNdh/
         6Ags8VhexSN4/tO5OF5RT2Uje8bjdq5HHhXTP7fqr0vWNVkyNFWIKR2/Q8QlsI+IPTqz
         16LXjQOOrrunN1xevzuaPEHJ8a21ubbXh3p3LYCM/svD80s2HlvPg1ucw7or7wElpZAM
         Fpjmd1CA6HhA7WS0X+nEDLgUn9Z2S+msQZgAhkWBvPKaRhb2B3134CotX3x3yI+EPn4X
         Y9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435847; x=1765040647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e0JrUY6rvuTDOtsRxKK87/+s+sI+ekupf3sIqBsYK/M=;
        b=sSr/CtftGvCzOu0Iui17ZN+v1MBVEnzO0tLy0ZuHzAZ9bLlMM/z6rf4GrW89ex/a/k
         OmGBBwfa9xg4FSLXslmGfV+upmsWVprG7AO6Aqg6Lq48i/fAxEKQ3MNBu6IvNaD2Ej2w
         3Cix2Iier61F1pfBM5NpoS1uzb8AECB1huHim68wCmwXFS+kG2O1Pn69ygxTSEtaRTiL
         AAZgSXroMMC/b2SvD3r9JIGxAr9xGngqQJkygzPSrKEGWaac3g6p39tKzyE4MlsltYsb
         TerXLBi9GM/C6k17bQ80PZElxLGMyOXIGm9770a+QrHXZW2zFa/MT5GOSoNwAsH0Zi3/
         jaSg==
X-Forwarded-Encrypted: i=1; AJvYcCXdFGLd2ow5Xyi8uiw6lYCjLB8IR2NAEckr2i7VD0bNZJNk+xxHQ6Q967SlKixR+3BcBAWHqJYcpxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjqt+PSUfKjGwYBhcUUdlsv22UL5D/OV3xcOcvQlHUj4zC6a50
	n7GP+Ec9EagHB5amZvHpbb1RWqJTzMbzuzL45ZA7iAx6Bd/IGJCREc7eH+rAusb4GH4=
X-Gm-Gg: ASbGncs7zOZtGbHlDHdswR7cv4lSc8uiv5PPK+lKcpi6VXaCA9kBOrMDPBkw9lKlOvy
	QQG3WGJD+UU2EyuMxzaszl6ElQDIdxbNE/Pda+JIAhM9v/lFdOG79/E8tEHPR3iMh/7uffUPe3m
	6zqC5t8WKXrZpjOh5gbsUacQpDrctrfmbg4ni+GuV4+p4DHcsz0704dsAc3l2fwa/5uwjIOFJV5
	rx+jZeUnQMb7rONAlhHrQyrs/nuZq2BOr84IMOJqiblJ3IJDhaSdeSDur8iHQ7Sz2IQ5GsNmUIH
	h5RaeiQ/C4IF+JJz8dpFPY1rJIA5hhVOByk0YznssJK/DWcNXYthjDcqppOpMdcy+bShKKsX3KO
	vxSJM1cVutDryKNfoKu9PgUzkQNXIolffBpEGr+y1hRZ0WwCVAJmpR/sEqWP65QHm2MbbxVQCls
	LgC2m95U/Ry1YZJDqe3sLl3PEqlpkPNiIe4ZlIlYjLod4BRo0i2Epv
X-Google-Smtp-Source: AGHT+IEsSYkJd/FdkKfzHFclbNhdV73ou4fwyHJU3DgvCYF8sNlh+2gMj51qTXwK/lGbmiBeIwi1Zw==
X-Received: by 2002:ad4:5c68:0:b0:882:4976:5eda with SMTP id 6a1803df08f44-8847c49c7b2mr465642206d6.4.1764435847467;
        Sat, 29 Nov 2025 09:04:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524e5cfcsm51008366d6.19.2025.11.29.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:04:07 -0800 (PST)
Date: Sat, 29 Nov 2025 09:04:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver
 Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH 5/7] iplink_can: add initial CAN XL support
Message-ID: <20251129090403.5185f2ee@phoenix.local>
In-Reply-To: <20251129-canxl-netlink-v1-5-96f2c0c54011@kernel.org>
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
	<20251129-canxl-netlink-v1-5-96f2c0c54011@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Nov 2025 16:29:10 +0100
Vincent Mailhol <mailhol@kernel.org> wrote:

> +		} else if (matches(*argv, "xl") == 0) {
> +			NEXT_ARG();
> +			set_ctrlmode("xl", *argv, &cm, CAN_CTRLMODE_XL);
> +		} else if (matches(*argv, "xbitrate") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.bitrate, *argv, 0))
> +				invarg("invalid \"xbitrate\" value", *argv);
> +		} else if (matches(*argv, "xsample-point") == 0) {
> +			float sp;
> +
> +			NEXT_ARG();
> +			if (get_float(&sp, *argv))
> +				invarg("invalid \"xsample-point\" value", *argv);
> +			xl_dbt.sample_point = (__u32)(sp * 1000);
> +		} else if (matches(*argv, "xtq") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.tq, *argv, 0))
> +				invarg("invalid \"xtq\" value", *argv);
> +		} else if (matches(*argv, "xprop-seg") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.prop_seg, *argv, 0))
> +				invarg("invalid \"xprop-seg\" value", *argv);
> +		} else if (matches(*argv, "xphase-seg1") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.phase_seg1, *argv, 0))
> +				invarg("invalid \"xphase-seg1\" value", *argv);
> +		} else if (matches(*argv, "xphase-seg2") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.phase_seg2, *argv, 0))
> +				invarg("invalid \"xphase-seg2\" value", *argv);
> +		} else if (matches(*argv, "xsjw") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.sjw, *argv, 0))
> +				invarg("invalid \"xsjw\" value", *argv);
> +		} else if (matches(*argv, "xtdcv") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl.tdcv, *argv, 0))
> +				invarg("invalid \"xtdcv\" value", *argv);
> +		} else if (matches(*argv, "xtdco") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl.tdco, *argv, 0))
> +				invarg("invalid \"xtdco\" value", *argv);
> +		} else if (matches(*argv, "xtdcf") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl.tdcf, *argv, 0))
> +				invarg("invalid \"xtdcf\" value", *argv);
>  		} else if (matches(*argv, "loopback") == 0) {
>  			NEXT_ARG();

not accepting any new code with matches()


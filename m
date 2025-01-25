Return-Path: <linux-can+bounces-2695-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB7A1C301
	for <lists+linux-can@lfdr.de>; Sat, 25 Jan 2025 13:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C361658DA
	for <lists+linux-can@lfdr.de>; Sat, 25 Jan 2025 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6672207DE7;
	Sat, 25 Jan 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKA8hrX4"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9023B0;
	Sat, 25 Jan 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737807096; cv=none; b=iTL59clPiRERPTAfiXiO/Ww2WABQBSM9Ut1hx9Uh/2gXSPmwR4+bc9eqxC67hpYkvtI+tNxHLG7B2Gk/yTx9Q9leH5J0NTorfaAAPgxwLYBcDRy5W/oPLu2H5ioZLDoSbxZYC+poiWv3zI+qQoEIgPt7rywzXHFQkXAYPuipVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737807096; c=relaxed/simple;
	bh=0Sq62rGkVluLFDqr7gWIKIX6httJdJm8ZgHh9QyyMoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHhnm3LHdM2VKfa+eI/HYdNN1Uq3Uvi/pnacZxxrINoIGvxRisncQD3uhbH33k3/fQPYvXa5ZzmTmoRYRDBzKN3jBwXcbzpVxBY85dJSanic2iXO5S2Rm4I2Uzi0IjixGmfrkYB4vonEQmZ8sLN10qkAoEEbh2j1fXAD7mzLN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKA8hrX4; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso20800195e9.2;
        Sat, 25 Jan 2025 04:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737807093; x=1738411893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Sq62rGkVluLFDqr7gWIKIX6httJdJm8ZgHh9QyyMoA=;
        b=GKA8hrX4RwYrKnRhNtoacLRYtpexcShivKuZr5+kjX7dSJYXktJ5wj0YQaD6dukpxg
         90fGFHA8tVDc+munj7lX+Yw+t37ktfmI+V4VsVkvvOotqj2fCezzZD4/4rWFVibxP4TE
         Vcmunr/TTlqst3UoNz5zmBnjk7smfQ/qTAXxhL9QpHHWet+ymfHs74A7A/lgT0FS8Idw
         xYNPw5mcH9FHJ77KFTIuqHFjRlB/HoNEAAzbxXG2RHSibzfXk9068mD+l401oKXmJRFF
         KEVDGq+cChU4MUCRbp/uyEQ/xhYpjv/e9rx3tuzukpqf5zwzu4FnFRlfeFjIVcgr2/cl
         WJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737807093; x=1738411893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Sq62rGkVluLFDqr7gWIKIX6httJdJm8ZgHh9QyyMoA=;
        b=vo6JV8zVbsA9MvmvxOcQcErzqQ+TCLPuF2Zc0MfmyrudR/mAIAzLbrzSGFldSZfow9
         Fn6p2kBcArA/wAOyiHeaZw2QI3xlJzv2XgedD9osARIb69JpChJlTl0PJ2m8C8RiTa1s
         hgiTPJsP++6Q9l6vbthbcvbyg6hM5tx/sSvoiB1/Rg4xOEtJBhxSduKJfkl1uUfbSPIh
         xYcU0Z6O4wWU7RjTlpHNe+bzKuuMeZ5s5p6XEBovrM8uotiVLEAa8ApA36TARZhctgTW
         5Rz5EeLd56tkggpELqL0SsJLZkv+4kp6IFkZP58ZbyhevgqKnm9rHg8O5yadrSJ2BzXT
         nu1A==
X-Forwarded-Encrypted: i=1; AJvYcCUkJlW+v+IWH2yLQK50vjLZTmjdHQCXWr/S94swe6sBF3RHhTNhERUBrkBB3vd/i1se1nkFM0V7lHka@vger.kernel.org, AJvYcCUsQfbvr0rkl4fY0xvdeOGznsj4cdSfz1oSbQFDX7UbZs9OtTEXpdAdxgvSL9C4GuuNp82V15vNicvQK9ak@vger.kernel.org, AJvYcCWyP33iTHKVy+MwrLSUBmmukOZefzEOqe5Fl+MGKruMXJigKTbug7PZAfgyrSNEyE8syc2NDcOq@vger.kernel.org, AJvYcCXLSDmaTxDvrs+AIxcnFTlikJR0I6Dya2PI7BPsPbDJCeIo3+t0BkeUGbSTkfJVKO1hZExmgMSjARw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKH+n+rO6IZYz5a3RBX7IPLMZhkItTuEoIntKDTalIi8AJu9S0
	aInqwCRwLMrPMBFQMB4u1j9xcOZBfDit7w899qyQuQOd1VtK9K1P
X-Gm-Gg: ASbGncsW2jLgouDJD4Q/e9dYwJeQ/ld0QaOBh6sj/imi0sdDlj7416/LBQJ6TJkdOKE
	2kntfcVyHXX/aZVU28dLLFC6V99fbULdmcf1mlcBXd1OcDRIWpMo3LwWHfijdxqRZZOVa/s8mKZ
	X/de7GDMzz9o63Gi7HgLRMinTCw0C8iwm/aiTg1wOHd3HuclRsG3IBMjNso35eepM8Om861M+Qj
	lRPxWi97Kv0XvvPCOj/Q3iC6Eq0hLZ0wHpT4ecGCbtp7vY7ZDPKAuf7dvO2LqGE/GYl+6wOkYUY
	kqX4rxNNNbpJKNui3qED8w==
X-Google-Smtp-Source: AGHT+IH6TvivVKS44JMlKYn8FJd3HXEjZU/eD+1tKhmVlxJIWwCbK+Y5O/hniODpO2Hi2P66c/u7EA==
X-Received: by 2002:a05:600c:3593:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-4389144eea8mr379103895e9.30.1737807093198;
        Sat, 25 Jan 2025 04:11:33 -0800 (PST)
Received: from [192.168.1.14] ([197.63.236.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47eecasm58348995e9.6.2025.01.25.04.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 04:11:32 -0800 (PST)
Message-ID: <5248fbae-982e-4efa-9481-5e2ded2b4443@gmail.com>
Date: Sat, 25 Jan 2025 14:11:30 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] documentation: networking: fix spelling mistakes
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: shuah@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net
References: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
 <69da3515-13c8-4626-a2b8-cce7c625da43@intel.com>
Content-Language: en-US
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
In-Reply-To: <69da3515-13c8-4626-a2b8-cce7c625da43@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/25 11:12 AM, Przemek Kitszel wrote:

> looks good, also process wise, also this comment is properly put
> (one thing to possibly improve would be to put "net" as the target in
> the subject (see other patches on the netdev mailing list); for
> non-fixes it would be "net-next"; but don't resubmit just for that)

Ahaa, I also should not have sent this patch during a merge
window where net-next is closed?

Thank you for the heads up, I will be spending more time with
https://docs.kernel.org/process/maintainer-netdev.html

> I'm assuming you have fixed all the typos in that two files, with that:
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Yes that was all I could find in these two files.

Thanks,
Khaled



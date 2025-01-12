Return-Path: <linux-can+bounces-2598-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0305A0A93D
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 13:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E911882031
	for <lists+linux-can@lfdr.de>; Sun, 12 Jan 2025 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430891B393D;
	Sun, 12 Jan 2025 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIDh0qAw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736D1B3921
	for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685723; cv=none; b=mWJDZ4mjiVpn5Qsxin1KQkVa7XRmGpIVABvJ/ROtlpEuvguezs3waQyT/nXvpXby9fOXQPQS0s6PpEHEJ/xIza9vfWp+XuoRtm+ZFhY9oV+omF2quKuc8VBw86M1JxPU3xJJUPaFR7RsTwnk5IE+ttXbUGb8/6/tz0lS5H0Zltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685723; c=relaxed/simple;
	bh=WwCKCMTIQX0T+V0nTBXP/Dt2z9BWijr4uu91WTSCBrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muiZxNpWqPw1CfhuPl4da8o/KVaQvnqW0PiwGcEIWZF6rVRN/WNaAg7Xz6WjpweurdQB2Lkp+oO17TfxtZeHe+VB+NtAUS9B+lIkw5Hwr7k8cyjAjG63/FqiCcs03zffwmNpJrORD6zJ/8lX+J14vMuyppsG6fyBx1LfHhDNODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AIDh0qAw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d44550adb7so590990a12.2
        for <linux-can@vger.kernel.org>; Sun, 12 Jan 2025 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736685720; x=1737290520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1GBsHHFfU1MIDjslUXC9PvCjTessZa41O3jurb6d4Vc=;
        b=AIDh0qAwdOKotbFWa+L+L9H+9NR1d7xMnGzoL3bMVSVv5iZAwLGr4ImI53eD3Lyvj9
         87XjsAtD7LbTb8AH3bP6rLHXZKEK7eK8v0yt2HqA/+oMylvtLeAIhx/gLj2LNl7XyKVh
         6qsrEHnKG8Wl6cuqakB6SybNzn2aTymhnxXAeOXMRugdS9btUQJ89O5H8K380u9iw/C+
         hDJCZZgWbzna1D0qQhytCP8kn904o739xX/xs+vs2PddjQ/iwHSdDY+upfW3ZREp3gDj
         saWWPGFJ6CjiXWfj5rxPe9poZ76F7ydaYCFTEmcXqH1BuggD2LVm6vjwL2B6jxe1Wlsu
         F4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685720; x=1737290520;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GBsHHFfU1MIDjslUXC9PvCjTessZa41O3jurb6d4Vc=;
        b=PRVWKYrVku+oXSGja+7ojjRWNLFq8Kah5NfVLReLfwvHv+EPHbyetIbTO57+YZCwbN
         7Ha9uTYaxBJErUe8idqvgl4TcIciQXA5WIxyxbNJCAMn4/mVovbTBEZ5aYTESOeZFh3Y
         ze6Ps/Wfyj3PcoWj3hHrY3cMlQMw+BhURMzyED356tflYR9MF1DHK8/df+jCo2eEo19Y
         6WoVI9TCK0uiyJKX1IWxTQr2pR+6cJilKD/A6M3bUIO9bgL46jx3ZoAazKuSSdDdWguH
         /8QwVMNP7SK7ZSf9V9CpD5/I/1CxZ6mZZ0CBtme8VaCH+s934VPRFZKLdxUYQBDlzvP6
         Co/Q==
X-Gm-Message-State: AOJu0YyLJy6oiPalHYyOEI4UWKVq0yf5b5P74EcX+iuJg+r4xCVz8Lb3
	Ym0BUMiwZ6diPHOiNAi9YIaMH4UTGJXqdcQlrnOHC7UF5kEyGKkMF3qe7OtsbxI=
X-Gm-Gg: ASbGncsGi4pONDj1UJNrzrn2jFjTY1SUiS91XBoLIYKHBbZShEjxXldTIKWSRnCyNJM
	T9dvkOrzOq4yIE0TMN4hRwIKncJKdxFpZSP5y2QlTgkyoqLqJ5qPAhyZVRnEFzMkfJqlA7+eiAs
	vJ+QwirK1vJAarAF78ad7AduUDNq6B0fZvPFO4nkDrh5SSAguVQEb2qfFuqeC/IP5sm3jg/7Fgj
	VXbZ0ZXGWvYofNDHc2yeRmTDmUPADqF1pdiJw1DOqIMhJt0gEsYLrFCZVTCS+dyHzVhfWeRzGqP
X-Google-Smtp-Source: AGHT+IESpOmew3WhN3qvKYetNHSXEDjFgrpEzfLow9gk4u8UwjjA1AYRzNiG617nAgAb7dL6Vw2m4w==
X-Received: by 2002:a17:907:2d8f:b0:aa6:6386:44de with SMTP id a640c23a62f3a-ab2ab73b693mr480622566b.8.1736685719846;
        Sun, 12 Jan 2025 04:41:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c906385asm370531666b.6.2025.01.12.04.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 04:41:59 -0800 (PST)
Message-ID: <af4c582e-cbaf-44fc-947a-ebd469251367@linaro.org>
Date: Sun, 12 Jan 2025 13:41:57 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] can: c_can: One fix + simplify few things
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, stable@vger.kernel.org
References: <20250112-syscon-phandle-args-can-v1-0-cb8448bf51d5@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250112-syscon-phandle-args-can-v1-0-cb8448bf51d5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2025 13:38, Krzysztof Kozlowski wrote:
> One fix on which rest of the patches are based on (context changes).
> Not tested on hardware.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (5):
>       can: c_can: Fix unbalanced runtime PM disable in error path
>       can: c_can: Drop useless final probe failure message
>       can: c_can: Simplify handling syscon error path
>       can: c_can: Use of_property_present() to test existence of DT property
>       can: c_can: Use syscon_regmap_lookup_by_phandle_args

Please ignore this cover letter, I made a mess with b4. I will send
patchset in a minute, as RESEND.


Best regards,
Krzysztof


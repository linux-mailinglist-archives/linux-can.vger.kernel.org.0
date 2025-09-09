Return-Path: <linux-can+bounces-4594-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B86B5066C
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 21:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF7F5E41BC
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 19:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999E238D3A;
	Tue,  9 Sep 2025 19:32:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE53570DF;
	Tue,  9 Sep 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446375; cv=none; b=lvGEGjtxeE+/T0HjG7FZ5r78fPVhaKsPSV1z71U0/I0DzL+nWbWl4ept59c4CXCYOJlkUQaSW6rXlSbsmBYQ0x/QJXO/qAcmk5eiL3T//RquD+KD+HhyDwXGkSBzJPLUE/45WpjamldqUOUbjKURp7EPVznWPNYibjIpGRpWNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446375; c=relaxed/simple;
	bh=Q24Y83PYxAn82xOr3QgtaMr48CkzfYcIqBbFLXVpIt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKA6MKPCtlb2Ng4B4yPwiRF6BFZ8Sp4pgC5k6Dr1wGHBa3LJeeJvfMqXemHFECt3SSDLlRbguyBYkR0QQ6o5pRUdKWWti1pEYb58xxEMHatchBDkHQAFfUDWls+q+SEx2oTySsaoRJfhpwP53mcSoGyqQldZqFFIZ2Ko7WsnSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b047f28a83dso1025549366b.2;
        Tue, 09 Sep 2025 12:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757446372; x=1758051172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPErOGuyq/UDXDDpB28NLJX02YikLqJ9vpBzKrMEycA=;
        b=umCR6JcCuX9QU3ubDjZk3JHW/kyfIB2vzS5a2FS2qhZqwJRYDWT5l3ZNLIWDhviiTp
         x0OF7pq60TvqtrWfkidp11y2OSZlqkJQhaGTliTUtcG0JjgvUGbfoGr5TkfolaiVDm0t
         F6n8wj6l4f2dyjidg40VWIBhsR1Ysupe8xluJ8lbTQaoU83zmsJzsAQqXOgv9W/t/ZJG
         uWEhdHCQRnsjyQW+h+351FGTStFp7JI5coUH41b0QUKtGJw7qVkn9tGw3K5XfuKypX+5
         G0lG8kLDoSQaEdoCfTJX7wgNenw1CsKLNM12nUodQHdvkDPedK4CAw8WGWCYXPh6Xz+k
         itGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/OInl3EDAn2qk5ipofXXZPSWq3VMD56RFUpps5k/mk1+zHek9Nz2IUvaioMWImCOCzQiFfzkk@vger.kernel.org, AJvYcCXB4o3tYWoxhSlfbFKIHhYyRgn4O34LQTzHj6UabwiE6kfWP0HTlJELzGTtkXeqC8z3kjnjwRZ/PSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjSsG1AeB5jiSvOO/8XvF8UWr4aFPoUX7R1fo6eqFUvl1xmm7P
	M5Y3GB59ZV2WeDVaNJcH13qnypYbzHwU9b1nJLk8XvTkZoPY5GCpyC/FxkT0aI5A
X-Gm-Gg: ASbGncvKSkftGFluSfXlV3i4PUOkpBbe/WB4YpxeOVQlun6T0TDSUTWroTw6U+vRM6k
	qY9N0QWbfiiXvIFIEVujRWZjtr1784kezi8IodvS78eEgLKJLALME8/AZQPhzmOI6imp2RbQC3n
	xv1yjXEcGAVMbYH+/kZI6U3Fx9uDsK81LdSKhvqyyIuLT7L6hMRbtBmrbGU+JeIEib7g2WGs+SR
	FrdIS3xADpHGYXPyNLTsbwfUIa8gEZytD3a61KeLwhFsB3B0N3hPT1QTA7p0bovBRcIqqrb9Mz9
	2AFPFehGJ62dyg8Oj35mAPMNjx3ytErs2AvtwZ5oWz5ScNTrqxp3HLBNIaPHNY99kxP2UIHAKTI
	yVnLtA9iyqmNwR7tpsxOX74mscfdFwfUQMaF2dP/UGPOC7BtJaisV4iGyDx8p/0dJM/L5
X-Google-Smtp-Source: AGHT+IEqYE7EAtGK0BC6pZqodPYEkIc0RGPvGo/Rcld6J/B7NHSUxuuv0OjkdHYQ91HpF2Ej53jzYg==
X-Received: by 2002:a17:906:c10d:b0:b04:6ebf:695f with SMTP id a640c23a62f3a-b04b16b50c9mr1254593366b.44.1757446372025;
        Tue, 09 Sep 2025 12:32:52 -0700 (PDT)
Received: from [192.168.88.248] (78-80-97-40.customers.tmcz.cz. [78.80.97.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830ab325sm40774466b.26.2025.09.09.12.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:32:51 -0700 (PDT)
Message-ID: <00a9d5cc-5ca2-4eef-b50a-81681292760a@ovn.org>
Date: Tue, 9 Sep 2025 21:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/7] selftests: can: enable CONFIG_CAN_VCAN as a
 module
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Davide Caratti <dcaratti@redhat.com>,
 Vincent Mailhol <mailhol@kernel.org>, i.maximets@ovn.org
References: <20250909134840.783785-1-mkl@pengutronix.de>
 <20250909134840.783785-3-mkl@pengutronix.de>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250909134840.783785-3-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 3:34 PM, Marc Kleine-Budde wrote:
> From: Davide Caratti <dcaratti@redhat.com>
> 
> A proper kernel configuration for running kselftest can be obtained with:
> 
>  $ yes | make kselftest-merge
> 
> Build of 'vcan' driver is currently missing, while the other required knobs
> are already there because of net/link_netns.py [1]. Add a config file in
> selftests/net/can to store the minimum set of kconfig needed for CAN
> selftests. While at it, move existing CAN-related knobs from selftests/net
> to selftests/net/can.
> 
> [1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com
> 
> Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> Link: https://patch.msgid.link/f1b942b5c85dda5de8ff243af158d8ba6432b59f.1756813350.git.dcaratti@redhat.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  tools/testing/selftests/net/can/config | 4 ++++
>  tools/testing/selftests/net/config     | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/net/can/config
> 
> diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
> new file mode 100644
> index 000000000000..3326cba75799
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/config
> @@ -0,0 +1,4 @@
> +CONFIG_CAN=m
> +CONFIG_CAN_DEV=m
> +CONFIG_CAN_VCAN=m
> +CONFIG_CAN_VXCAN=m
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index c24417d0047b..18bec89c77b9 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -120,9 +120,6 @@ CONFIG_XFRM_USER=m
>  CONFIG_IP_NF_MATCH_RPFILTER=m
>  CONFIG_IP6_NF_MATCH_RPFILTER=m
>  CONFIG_IPVLAN=m
> -CONFIG_CAN=m
> -CONFIG_CAN_DEV=m
> -CONFIG_CAN_VXCAN=m

Not an expert in the CI infra, but the link_netns test clearly
still needs these configs enabled in the common config file:

https://netdev-3.bots.linux.dev/vmksft-net/results/290682/56-link-netns-py/stdout

# selftests: net: link_netns.py
# 0.12 [+0.12] TAP version 13
# 0.12 [+0.00] 1..3
# 1.44 [+1.32] ok 1 link_netns.test_event
# 3.99 [+2.56] ok 2 link_netns.test_link_net
...
# 4.13 [+0.00] # Exception| lib.py.utils.CmdExitFailure: Command failed:
        ['ip', '-netns', 'rhsbrszn', 'link', 'add', 'foo', 'type', 'vxcan']
# 4.14 [+0.00] # Exception| STDERR: b'Error: Unknown device type.\n'

Best regards, Ilya Maximets.


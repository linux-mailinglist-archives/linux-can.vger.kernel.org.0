Return-Path: <linux-can+bounces-6927-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJn7HVVBqWkZ3gAAu9opvQ
	(envelope-from <linux-can+bounces-6927-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 09:39:49 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3D20D907
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 09:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57863301BAAB
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 08:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807FC374E54;
	Thu,  5 Mar 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zhs1szgR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jftXYqSq"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA16288514
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699983; cv=none; b=dwb9f1EZ5B8X1sdqiTcYLzpUu6/76outUFsoJx+bIHCchr4su8a1HVOjMDOzemaxfNbvJkG2bfYCRrSojh0JAg4oLDny93PsT5nuvZzVZgyOngculCIB1tX1OyluN8GTYVcIE/hg+O3lw+Qvsh+TKNerCuNuKu6S5oftE1kDwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699983; c=relaxed/simple;
	bh=6xaS693NEPvMsmPDTvB8J6q5UsLGM4wm4qipY7xfOGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgTe0q7m7j1NKTtYNv139E66TgtaQLNyzLwI9EWXMHh2i5HZdkNqFBlpffJraGOur7YSh4NPQRfTikfPvWH32TQv/zeoihfDPPODDJrfiZG6/btGPrNkNkrqkz8gGd/0k5FZcdnAjuyWiuWvd1v9QAz4bQiJZnNdF7OXpFi3NnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zhs1szgR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jftXYqSq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251BuEw3483047
	for <linux-can@vger.kernel.org>; Thu, 5 Mar 2026 08:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kdWMwgc8nLSwvc7+zSIUZsTz2pEGRMvswxdPfflnvOo=; b=Zhs1szgRs6PvG6yC
	/K6l0Og7co3C6ED8icQT7ngtsI9G5Zp17IaIYa/MOFJSyTxAUHo39qtMLOBGQhpj
	JO9fE/F/E4F4LvhAKnAlFKn+fH9sEpkGqfNT9M43WTCJkjqaFeUzfOGpTrDAGNtC
	tA5poP4iW9oFEFa2er9A5XyBDJ8CedmbmCYM1jjJmOXgrD4UqsM96/EbUTiVA/x+
	+Hq4ib0d4uJFejDRNFTAYPM9OxAzG41cfjw0IJBJVDWkmbFbGS1eLwFkvUDxUI+x
	i9yGzbk3U3z2KxBfUGbK5GoyOmpZPSUHhrYGJ9ek999ywA1Q/YTR3XTo5MWWFrPw
	1lqwYw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wjg6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 08:39:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb50fb0abdso615772885a.1
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 00:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772699980; x=1773304780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdWMwgc8nLSwvc7+zSIUZsTz2pEGRMvswxdPfflnvOo=;
        b=jftXYqSqtrokdujho1rSZ8RV2+df0VSJJ/M8ZUZxSfL+guycXk5e5Oa+/kyiYv6qq7
         wDt7pgwE82GoCanbnE56n+QEoFdpyD0IDJAXa2uedcbQvZQWJRRzpQWeE+FA2evLbImb
         HHx25k81XwtVs8AYIfGmGN1Heris1W4EH+3TjG9IsAQO2tfFNcYJFHacx8H5ixGQjhjp
         YhLkHjONVRBKpyl+EoAHQo2i8UAnKVr+iozz53JeeF4uhO8r6lRrGpcB/0Hhik80AyD3
         +bPbUwPZDvHgZwinc1JyJ5+XebVWXjYBrsXBjFQwXL48HKIXO1qH/SWx+i+izxWR3tKA
         fXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772699980; x=1773304780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdWMwgc8nLSwvc7+zSIUZsTz2pEGRMvswxdPfflnvOo=;
        b=wTQzr/AumDuTdD4k9c5PUBR5Vllf1HJhvdlUojH2PVppnLuh/QGv/iWkXgJNyfUACb
         DvTDhFNX4hNCe8WTv3h/JCXnpzD7QwZCIZ6DtXdPdBfGAR4wdjl3LdIdUPUFywrZAnDu
         8zNgb0UY7eTYAzYu7OEtBfxfSZ4bJMAsQXB40vd7yvaMuuJVIQ1O7jD5c4CM4klWSsg7
         Be6TobDl/zWXVxzYHy6UIJpAWCWxhFmGV0qYQy17fOlTkHJHBjkPPTPOY1pkyRzMEHRk
         EwURLKOXp0fpqu2FSQYmZuwP0xU+wBNm2jUpRpkm8X50GyKSkRtsPVhNIl977BOwRnK6
         uC9w==
X-Forwarded-Encrypted: i=1; AJvYcCVt1Z3LxrxntgqSsisRI0q04qAigF8hZhQosbGYC4gFAevEZl3Hfjetu7o7gNtKAdBzkqQBDO8wEqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpTwgoJW/E4VYnL7HxMpDA5n0QM48ZDJn93DnXwjxv/SLeWwy
	pagPu0nUb6oHcXaIRjw4iunbcaXTCpHaAhlFH1XEsA1tc6UDOqjuvfm1Tu+FdmUchSXEiOLH8nR
	pYaIIDuBCzYn/OhysE1hapl0l2TTHu+fVJHM65WH0+hhnzY2fEYFT3ZGR08ADp5M=
X-Gm-Gg: ATEYQzz1d038GL1zM4QeCOYQmDRNCdugxWPecMrkTk1aQ2dV5YTY7GgweRWDVh8Mg41
	6zXFdHuEuPjykq3TQnGk9b5MEVNWabn3D911nMttgSzu+RaoD/P4hxOkloLaLmrmKF7XwxVnK8B
	FRTKSk9bjd9lVfaCKTG82potEtdKevD69mOZ9+cFa7CcRBA6OHqip6QBvEeD7koBRrO7GPlbEQ2
	1WNzkZqXtNywV4aEapZBgXg46Q134bYL6RnUKzWA74w8FAkvaVNnWbs/PzR3Jbxjats2D+b5Ju4
	6u8UFpPFXQd/DTRAB56qbajwWZhwg5IYd2k2mvA71ODcj98TQoahmJO52KXUIhraM6xoj52mvNW
	xXS96hbuKNzjvK0tnKUJzY+TMVjmTpqYS/DixDxzCMITVk5VxWwiaCn6J1rcgBvmDNVdrqrHK1I
	5JD+Y=
X-Received: by 2002:a05:620a:404c:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cd5afcdcfbmr452360385a.9.1772699980158;
        Thu, 05 Mar 2026 00:39:40 -0800 (PST)
X-Received: by 2002:a05:620a:404c:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cd5afcdcfbmr452356985a.9.1772699979710;
        Thu, 05 Mar 2026 00:39:39 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fac06e3fasm6657504a12.25.2026.03.05.00.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:39:38 -0800 (PST)
Message-ID: <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 09:39:35 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
To: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260304175735.2660419-23-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: umUDbO3Qk01JqUL76kimNwhQNp8yScoO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA2OCBTYWx0ZWRfX/tSHldBrkQNf
 KM/cu1Js+9nDep2jONrzTNrwsgrY9deEeSiEP4r653REGkWAHnp97ZHDhVUYM2KZB8pEbYcg6De
 UWC7L7Ph4Hh0lEs7ClMgHRJxf45h8Pe7++Cu5nLFvZR1n4b8wcvRuCJzddatqUXI/BwZsDBUCI5
 iEhkpE5RED5FKiTC37PDYQcB08szT9UBUbEbrZsRY0aYXa7vOANRUXucA5nvGQpCp8VepMIPqmX
 WDkkcMwkpWoQPMbGlmE88CWb859WcJmhi/nvqQNJHen8zaqmPhyw6Z8BnpPup06ML/Ja5HNWvwo
 vqEP29iwUYinLYbxnJl0H9MQJBYjMLE/3wSHNFsrHr7W0mUYSrHnx5qR9tyXOMA6pFOfsibcNZf
 JsvV1a9y44FI/R6GS1cpF7GKPSpzfUeMt0YE3TiERzRlAEQXxkXqG3XLClc2BpPmq0H8ztyzr6f
 btkuBTXq//TY3K7DIQw==
X-Authority-Analysis: v=2.4 cv=OYWVzxTY c=1 sm=1 tr=0 ts=69a9414c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=8AirrxEcAAAA:8 a=GJStlgXwfe-SXQdWLvAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: umUDbO3Qk01JqUL76kimNwhQNp8yScoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050068
X-Rspamd-Queue-Id: 1ED3D20D907
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-6927-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/4/26 6:57 PM, Vladimir Oltean wrote:
> Some pragmatic shortcuts are being taken by PHY consumer driver authors,
> which put a burden on the framework. A lot of these can be caught during
> review.
> 
> Make sure the linux-phy list is copied on as many keywords that a regex
> can reasonably catch.
> 
> For simplicity sake this is not perfect (devm_ and of_ are not valid
> prefixes for all function names), but I tried to pay attention on
> avoiding false matches on things like:
> - drivers/net/vendor/device/phy.h
> - include/linux/phy.h - network PHY, not generic PHY
> 
> So I used \b to try to match on actual word boundaries and be explicit
> about what is matched on.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..bdfa47d9c774 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10713,6 +10713,7 @@ F:	Documentation/devicetree/bindings/phy/
>  F:	drivers/phy/
>  F:	include/dt-bindings/phy/
>  F:	include/linux/phy/
> +K:	\b(devm_)?(of_)?phy_(create|destroy|init|exit|reset|power_(on|off)|configure|validate|calibrate|(get|set)_(mode|media|speed|bus_width|drvdata)|get_max_link_rate|pm_runtime_(get|put)|notify_(connect|disconnect|state)|get|put|optional_get|provider_(un)?register|simple_xlate|(create|remove)_lookup)\b|(struct\s+)?phy(_ops|_attrs|_lookup|_provider)?\b|linux/phy/phy\.h|phy-props\.h|phy-provider\.h

Would looking for the devm/of_phy_ prefix followed by an open parentheses
not suffice for the 'has function call' case, instead of listing all
currently present exported functions?

My worry is that this approach is overbuilt and absolutely no one will
remember to update it

Konrad


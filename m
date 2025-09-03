Return-Path: <linux-can+bounces-4449-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5CCB420B8
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 15:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BD3580DCC
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673523009FF;
	Wed,  3 Sep 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1XAqNyxb"
X-Original-To: linux-can@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A62FDC43;
	Wed,  3 Sep 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905234; cv=none; b=G1q6uGZQmnTrmAzUNyAyxpYGl+KXJZpRQ9aT8BTVf8Coj4g0NIZi9FG4TC9MHxD2fP9hvNEQYO/zzSz5IrCscCryw3qQ0zJ1o0yKpavY9IUllpRcE6JgL6Kn20XrykMn5ii94YUHk4YzmHXDILk0eS2Ndl6CnqU5k8yHYz1LrBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905234; c=relaxed/simple;
	bh=m3KpEmxd79c1OD6LqRkUh0rEK3120b65Xfyz+Q2Hd8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pvBYlZgaS+Vd+WaoKTqX1KaZITDWz7tf/AGTK+POEIJFUNwUEIIQvBKUmQHb0HqdVpAcV09LKo7HeyKbSG9sndipj1RYsQ2WzD+n+ZnUNtjFKbWKUCn3JSnCQk6Lm96rBFCB93opNuk5gyK2cU9FPr8vZQMgmsWUoIG7vcgReTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1XAqNyxb; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Cav0x002331;
	Wed, 3 Sep 2025 15:13:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	RXR6l5zH9EuL6ygVcZdx0q8KXP/yLgdiG12ZI87yuuE=; b=1XAqNyxb4d0nLr+5
	/nhC7xFCng4Jy7BmFmFwA/fpX3aQlJxJ5gqJ9vIIptA1g7UdVjnJkMSizX/xx1yt
	uJqY1ad5BbFYKSNncLqKqzBvnraO1r5QNIjc/JtP59wmhkFekHmeVArisrcVmAmd
	Mi4FpTXOJ8JLMyAlzf+J7sMUXkz8BrXcYvjkRr5/g2CKbLF0ASzOGFqDTZFyNzvL
	zWWLtppycLqkRe0PccSj0f7qAByaCMOIMD8/KNC4vqvdA1hS0mOTjjpnG0Ykbz/y
	Sc6Iy/gcH20DLowj/lHthmw5rXjWUAAz3BgYUCLzlGBttwwFTlmHbG6ZkxIQLX8N
	okP9Og==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48ur6frhek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 15:13:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DD40540045;
	Wed,  3 Sep 2025 15:11:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D9020290800;
	Wed,  3 Sep 2025 15:10:43 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 15:10:43 +0200
Message-ID: <59f25804-d310-4492-b95f-19c42cf3cd42@foss.st.com>
Date: Wed, 3 Sep 2025 15:10:42 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: stm32: add resets property to m_can
 nodes in the stm32mp153
To: Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chandrasekar Ramakrishnan
	<rcsekar@samsung.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@pengutronix.de>, <linux-can@vger.kernel.org>
References: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
 <20250807-stm32mp15-m_can-add-reset-v2-2-f69ebbfced1f@pengutronix.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250807-stm32mp15-m_can-add-reset-v2-2-f69ebbfced1f@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01

Hi Marc

On 8/7/25 08:09, Marc Kleine-Budde wrote:
> On the STM32MP153 the m_cam IP cores (a.k.a. FDCAN) have an external
> shared reset in the RCC. Add the reset to both m_can nodes.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   arch/arm/boot/dts/st/stm32mp153.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp153.dtsi b/arch/arm/boot/dts/st/stm32mp153.dtsi
> index 4640dafb1598..92794b942ab2 100644
> --- a/arch/arm/boot/dts/st/stm32mp153.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp153.dtsi
> @@ -40,6 +40,7 @@ m_can1: can@4400e000 {
>   		interrupt-names = "int0", "int1";
>   		clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
>   		clock-names = "hclk", "cclk";
> +		resets = <&rcc FDCAN_R>;
>   		bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
>   		access-controllers = <&etzpc 62>;
>   		status = "disabled";
> @@ -54,6 +55,7 @@ m_can2: can@4400f000 {
>   		interrupt-names = "int0", "int1";
>   		clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
>   		clock-names = "hclk", "cclk";
> +		resets = <&rcc FDCAN_R>;
>   		bosch,mram-cfg = <0x1400 0 0 32 0 0 2 2>;
>   		access-controllers = <&etzpc 62>;
>   		status = "disabled";
> 

How those reset are handled at driver side ?

regards
alex


Return-Path: <linux-can+bounces-6573-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FkzNlcvk2ke2QEAu9opvQ
	(envelope-from <linux-can+bounces-6573-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 15:53:11 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A6144D65
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 15:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A78E530015B2
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBE311C27;
	Mon, 16 Feb 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PqZ/ulcc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="La4ACJU/"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B724337B
	for <linux-can@vger.kernel.org>; Mon, 16 Feb 2026 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253585; cv=none; b=k005OZ9teBrs17VUmb0ZYefGrLt1NlNTwQ76Ewl+BdsKNJOB1K8lNppNXVr6n3TQJG3CrrefICrnrl9Tx00tMNQ/VBTJhm4fKSwwxGtbKNbyWcwRGyVYUa5aFa/snliaTEBkKcaaTM7NCZ4xEoozuJ22a1CU8bMNrf2zbNH/09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253585; c=relaxed/simple;
	bh=//3K8HdIM6iIVP3vHlJ8uNpIGBfV9QmTS5aaeAemVZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7oSmycbaX/T8hMOYngdRnimInByCIzKr5IN65RiKy7B355tn2sHgG8ublv0ejHYuepHYxoN9SfqGumfu7FF4x6KmLfxwIbYuiXhfZptQO7jMABAxtCZu3UwIZ7uNFHdx3knm8BUgew7VdNaCvDsMn86xyYSdFcuZYsR96ToiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PqZ/ulcc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=La4ACJU/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GAtBYX2647738
	for <linux-can@vger.kernel.org>; Mon, 16 Feb 2026 14:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UYOpEMLzfy7q9oSdUsVOLuafnhSAm2l7iQcWVRgB1kM=; b=PqZ/ulccZPDhxdyR
	tv+pmVGqyKh3sUTxJQ4z6vTy465xOGZ/BUENWKGg81prE9AIR6gSXSX9OGcKNffR
	HpBdG9qPJFM2yIMcyQQTicn7RIVLFu3s2BcrtmfyumOPV/1Ad4WewZcL44vOqpdk
	U+d0wS2V+JJgOAlPACnV3zY4QTW/wyJaOgBGTiPR3EAQX6qv08rncSXkc2pxT6ES
	BjMjMDLkBbnxkHwqmIb2qV6IT0A4Nr+h/Al0iNn9WooCdMaOuUIFmFTPx7BByrUw
	lBl5ZgR0i9e2r196og++oar2AOAww2HogRoi1BgyHUnkQPWP5JfHw+I9Ix2+jLKG
	jLWe0w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbfuw2fa1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 16 Feb 2026 14:53:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ed6c849so1834685485a.1
        for <linux-can@vger.kernel.org>; Mon, 16 Feb 2026 06:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771253583; x=1771858383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UYOpEMLzfy7q9oSdUsVOLuafnhSAm2l7iQcWVRgB1kM=;
        b=La4ACJU/KpFH9T54r+YiRVDtEwbza+xTRFxOTVp31klrIPNfk+FJLhQfKmRd7hXf9y
         HE5CjdYrDSRqUIWGiBCvHZuYLl6ukz0J28EyeEJbTzm5HnePFXQo52ld0NO/NQNxRY7z
         bvaXghWaCSfCuTi6NdR+UU6HNsS2XC1zwBrLjxc4JcC5vPXcamAcGp1uJXnbX6N3G4ty
         qM1IUk9X+LiQNdQaHN41MI5W71xVgreQLvpDw5mpyB4LCp6Qqr/osPPB8mY5JdV+og93
         K2mWvGemBLSDrPsMtRodfb4lt1rBV5g3GfupBcAc0wDTVSAOJXlaeGggkU52Wu4YEvzE
         NNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771253583; x=1771858383;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYOpEMLzfy7q9oSdUsVOLuafnhSAm2l7iQcWVRgB1kM=;
        b=Dpce1e8Xzjj/qAhWU6nlnfhSLb+nIMQbso9j3wkIgGjyqmWjU5Swar0NB1XJkZrj8F
         q5zUncufJWyR8vHjMQ1w2Lg4TfR0O+6v8T9iDnZFjnogcVp0nP1+eBWXIW9GOkVGTGhV
         oP2rq5giWSjh3F98qfYXm34dRuIolsREBZXal0Cm6uazUyupoBEqYoQu+W65cR8Ci7nO
         F3psGRqfg1toQMLzfz+EuS+zXcE4uJr+Y0ENntWpRBlQ4GWJIzMSnH9oOgo0z2shp8wY
         zAxt3gnlmmTfSkmqgpmXgYxsnhUIxBg3phg4AAbptSVtf/HPpfdKpCOOmS2gIfOiHgSc
         4MJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbc1mpSpavVOTwNv2dQj9orhPItMVDOyurTFhGB2PhWq5vwPOPFmzYL8fanPlA+/oEuHO0If1lDXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoPwzdf6gIjNncpBlOIetM1ghb+N2WeDneTOFijvHVy65+dte
	b0hV71jj4yJtCzFzx0okaymL5xk2yDWwW6xJeK5Fit/F2UCtHqcatkobtsAT1UbTz/e8oaCAIpS
	Bv81gLPDRp+t1qcEq0LRWs1yQJbCVuiPpUXJ1Mp917r8tygwhZQj1aI8cQceJhHg=
X-Gm-Gg: AZuq6aIsEJvuhX3KC8g0fLbf1So3tcSp1lVo0Z8WbLWR31qDlUfXxqdTZkftyjKhYZc
	BgsmocKcXtlw8B0T4/ok2VqFtk40eIUmQpDnOVgKd+WLMpmsYpRb7s+iflp/az3uPr7P3PUUm6+
	04CTAMUKpFXf7fX6+Z7et5LJNtS+kxO/D3TYSTHIQivh/Y0f6EggSPh0aNT0bUOceEjrMUrp3mk
	8kFeLzBOwdEGTqRpXvCvJL3R4NaZciSAIWF+WQW3Wyl/q+PyVl+XLoItHmfSi17yXRw1R+dxca+
	7Q54B3RzC6NrL5Rfhqg6R/nZyNQb+kM/YGKZT49BpAyHkZLf1MgCbb87FGEfDrChSoJ+CY328c6
	U5FQsPO1ig9kRkhJ7sx8+pnKkslNgEApd02osOfeF10jm2gX5nQ==
X-Received: by 2002:a05:620a:4407:b0:8b2:f9ac:a88b with SMTP id af79cd13be357-8cb422822dcmr1225631285a.21.1771253582877;
        Mon, 16 Feb 2026 06:53:02 -0800 (PST)
X-Received: by 2002:a05:620a:4407:b0:8b2:f9ac:a88b with SMTP id af79cd13be357-8cb422822dcmr1225627885a.21.1771253582361;
        Mon, 16 Feb 2026 06:53:02 -0800 (PST)
Received: from [192.168.1.29] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b07fsm26796604f8f.2.2026.02.16.06.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 06:53:01 -0800 (PST)
Message-ID: <5337a9c5-f612-49be-8ddb-8148138d004d@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 15:53:00 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] dt-bindings: Add vendor prefix for Frontgrade
 Gaisler AB
To: Arun Muthusamy <arun.muthusamy@gaisler.com>, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mkl@pengutronix.de,
        mailhol@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, Ludwig Rydberg <ludwig.rydberg@gaisler.com>
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
 <20260216135344.23246-2-arun.muthusamy@gaisler.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260216135344.23246-2-arun.muthusamy@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Jb+xbEKV c=1 sm=1 tr=0 ts=69932f4f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=ebG-ZW-8AAAA:8 a=EUspDBNiAAAA:8 a=HZE-oCv7Mry4y8xlBPYA:9 a=QEXdDO2ut3YA:10
 a=0lgtpPvCYYIA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Bj2TwAA_C77lQ_X2_dkp:22
X-Proofpoint-ORIG-GUID: 7QNvmx5gtaiIkEaF8dvUCZM_akvOUhdS
X-Proofpoint-GUID: 7QNvmx5gtaiIkEaF8dvUCZM_akvOUhdS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyNyBTYWx0ZWRfX8RKVJBbDpm3H
 5Az8foGoFk3SFP/C/TCLOWsciZiHh7c1oP6pJzFtucn2nP3f7vo5t9i7HJzFbBijsEhsEKXtREU
 vrAGzaKVSzcXuNYPYPERq9XW7wF+z1QQOEKpzVzpkCjYDM1iujvoMgm58GrWdJWtYhFCo69wsNw
 2v3dFYFPdkGhdWRl2RchVTjhgbpbXoMDwczOJ1nQks6XnXfuEX4BRzRV47t47vabUxG9PCMzQp4
 v6Ipvhi1k4NlFbWjITfGUGNBUUSXLS33ra6+AJG8WblKLlbNd62HkUNv4KYt+q2q7LiPE2zy5yn
 yYL7ory1pz25RWQUiCnJHgASkGpUgBaW/MrA9rnawNJEqxQOU7e7KzI2JPz6g2imn+iRlRsHuMn
 z2+VJ8/qU5WZdgSWwMSB+2jzmuzV39Ez3j+0SHTcj2fI0/XBoC8r99NviHCHqhS0RoJIpVoRWHR
 G2BoL9jO5igRZG/1LLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160127
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-6573-lists,linux-can=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 104A6144D65
X-Rspamd-Action: no action

On 16/02/2026 14:53, Arun Muthusamy wrote:
> From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> 
> Frontgrade Gaisler AB provides IP cores and supporting development tools
> for embedded processors based on the SPARC and RISC-V architectures.
> Some essential products are the LEON and NOEL synthesizable processor
> models together with a complete development environment and a library of
> IP cores (GRLIB).
> 
> The company specializes in digital hardware design (ASIC/FPGA) for both
> commercial and aerospace applications.
> 
> Web site: https://www.gaisler.com/
> 
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>

Incorrect DCO chain.

How did it even happen? Look at your previous patches and do not
introduce some random changes.

Best regards,
Krzysztof


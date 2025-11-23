Return-Path: <linux-can+bounces-5618-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A312C7E1EC
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C023D341CC4
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DA2BEFEB;
	Sun, 23 Nov 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePF4htYd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC751DFDB8;
	Sun, 23 Nov 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763907703; cv=none; b=m3V7aV4rxUpmTGSy+vbJNV+dp4iL4s2rL0r5w18fn0YKdL3RKxUpmLTiIksfzocazBPX72yIX7GF2GtFvZIG5OHj8SD/cR4Kdzt3rM/XDYbbQ4KksGeioHHNmrG3sAP9LA0ZRLMDCb+gYnqkBUivXIhI+chEELbZqB5ucFSZLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763907703; c=relaxed/simple;
	bh=EdEqR0greCo4vN/V/+DFuTUKUXzaY8bkQ7htnKoJF8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaRb0W8qnetMuuoQhDn3c8t3RMj/gFq24neBNVTSIqglsyAuqCPnzyYEZx3K9sFUa/IAUXdS2WJmubcz+7bUddC924jaQCx8AFzg+bZG560Ea0qNyKb8/79DwD5ZXmnEBNEhBwdKl48D4RRNWoDktg49PwEwxqhKDm+DNLtKL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePF4htYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11008C113D0;
	Sun, 23 Nov 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763907703;
	bh=EdEqR0greCo4vN/V/+DFuTUKUXzaY8bkQ7htnKoJF8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ePF4htYdnoRbHZ8nxb8lkLWMK1dfskLmwAJb9VLJUaISPEvu1EPdWAW+4SA+KvG1v
	 mNxkaEcZ7EBfUbO8B+C5gJT3Jrnh0/7JNpU76KWvNMemMvsbme4VI7JETUUz0Tw+Dy
	 QPCX5T46audWX/Ya+08ZrwqFlvqD9bWaldXMmv1skTvPINwg9UCp9E5l6cGhIrqVVu
	 m2QYGMjHyDFjmZRjY/4XTNz6jsljyfTRlJionyzSg+PmcLaqXRBRlRzadm+y/d2EZy
	 m0M5D3aMPmA6vmzMFMsrmwP2s9akjkRmRghCYPjDLFY37Ul4B7aYmWxo3vBsCZ6sjx
	 RdLitXu3E2S4Q==
Message-ID: <24a71741-df53-4726-81d1-38c9eb3ad12a@kernel.org>
Date: Sun, 23 Nov 2025 15:21:37 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
To: Biju Das <biju.das.jz@bp.renesas.com>, "biju.das.au"
 <biju.das.au@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251123112326.128448-1-biju.das.jz@bp.renesas.com>
 <20251123112326.128448-2-biju.das.jz@bp.renesas.com>
 <3928e893-66e1-4873-a78b-75e38e746661@kernel.org>
 <TY3PR01MB113460EC3CED97F90FE121AD486D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346729E8758CFEF18C9E99686D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <TY3PR01MB11346729E8758CFEF18C9E99686D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2025 15:17, Biju Das wrote:
> Hi Krzysztof Kozlowski,
> 
>> -----Original Message-----
>> From: Biju Das
>> Sent: 23 November 2025 14:06
>> Subject: RE: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
>>
>>
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>> Sent: 23 November 2025 13:26
>>> Subject: Re: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd:
>>> Document renesas,fd-only property
>>>
>>> On 23/11/2025 12:23, Biju wrote:
>>>> From: Biju Das <biju.das.jz@bp.renesas.com>
>>>>
>>>> The CANFD on RZ/{G2L,G3E} and R-Car Gen4 support 3 modes FD-Only
>>>> mode, Classical CAN mode and CAN-FD mode. In FD-Only mode,
>>>> communication in Classical CAN frame format is disabled. Document
>>>> renesas,fd-only to handle this mode. As these SoCs support 3 modes,
>>>> update the description of renesas,no-can-fd property and disallow it for R-Car Gen3.
>>>>
>>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>>> ---
>>>>  v1->v2:
>>>>   * Added conditional check to disallow fd-only mode for R-Car Gen3.
>>>> ---
>>>>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 24
>>>> ++++++++++++++++---
>>>>  1 file changed, 21 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>>> b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>>> index f4ac21c68427..a52244f0b5d1 100644
>>>> ---
>>>> a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.y
>>>> +++ am
>>>> +++ l
>>>> @@ -125,9 +125,17 @@ properties:
>>>>    renesas,no-can-fd:
>>>>      $ref: /schemas/types.yaml#/definitions/flag
>>>>      description:
>>>> -      The controller can operate in either CAN FD only mode (default) or
>>>> -      Classical CAN only mode.  The mode is global to all channels.
>>>> -      Specify this property to put the controller in Classical CAN only mode.
>>>> +      The controller can operate in either CAN-FD mode (default) or FD-Only
>>>> +      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
>>>> +      property to put the controller in Classical CAN mode.
>>>> +
>>>> +  renesas,fd-only:
>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>> +    description:
>>>> +      The CANFD on RZ/{G2L,G3E} and R-Car Gen4 SoCs support 3 modes FD-Only
>>>> +      mode, Classical CAN mode and CAN-FD mode (default). In FD-Only mode,
>>>> +      communication in Classical CAN frame format is disabled. Specify this
>>>> +      property to put the controller in FD-Only mode.
>>>>
>>>>    assigned-clocks:
>>>>      description:
>>>> @@ -267,6 +275,16 @@ allOf:
>>>>        patternProperties:
>>>>          "^channel[6-7]$": false
>>>>
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - renesas,rcar-gen3-canfd
>>>> +    then:
>>>> +      properties:
>>>> +        renesas,fd-only: false
>>>> +
>>>
>>> You did not respond to my first paragraph from previous version. As I
>>> said, you now need oneOf to restrict these, since you are not using simple enum.
>>
>> This is restricting for R-Car Gen3. DT binding check returns error if 'renesas,fd-only"
>> is defined for R-Car Gen3.
>>
>> Am I missing anything here?

Add on G2L no-can-fd and fd-only. What do you see? What is expected?

Best regards,
Krzysztof


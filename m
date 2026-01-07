Return-Path: <linux-can+bounces-6019-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3A5CFC9E8
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 09:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 262A03012DC6
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AE7276049;
	Wed,  7 Jan 2026 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpDsd8Tm"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372CF9C0;
	Wed,  7 Jan 2026 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774534; cv=none; b=QiV8lIF5K/4sFQ6Z7+3fY07JK8pHMGjDtBgZyNNvJFWBwJbGY0hsDvNcCzgEV0zqRbTlc96nD6RxiVmvX/Ysv9215fmk/taXlb4PjoGkFfNc6QLc01qlJ8hPCEp2LNOzrucWDoM2tYeYKobS9mA2ujNY0xpGCx1vqEIWhwQCHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774534; c=relaxed/simple;
	bh=cCk0sHw1PB/PAhG6gFIAaY7n2hvDjGktzWLgL7sRtIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NErdDBsQgcS6xTQuNrgEd45NOfXCxYdn4gsDg297VINyDIAC36CsuQxCAlkVKG7E7o1L1+7KIC2oN70o7PGlgAqTUJOQBF+pVL5qU33QZ9js9s6A4biEYnvRyUfMDadYjjWwG14YcO7fKv7oVkg5r31godhJtBEBc2nlnEyrVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpDsd8Tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553C0C4CEF7;
	Wed,  7 Jan 2026 08:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767774533;
	bh=cCk0sHw1PB/PAhG6gFIAaY7n2hvDjGktzWLgL7sRtIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jpDsd8Tmv8upb7mqV2DPDILsK2/2asyVi2gwyX/RVfYsqsiphT5Qc8k2lQlqYncV0
	 KpSk6zsFfqZJnR/eD0UrEuK0fqcxZcdjuKWiF4sQz5D1Dr4OgFVzd/uj8uYe1d607L
	 F8lqS1S+wY5XcTVg/dq1Z7YTV2ECttcluxsVDfsTXAPALWN+PV60zC1z2Uil3sJIgN
	 jd5Kz8cEg0Rtch/O0G8aJNBzv4kFA0e0UZk11S3zvhQLRaUJF+qBKfsDb2Grca/72r
	 EGEiq1SKKqt9BuuhtBa4aS6wpkUy7/x23ohjPzN/IibWweEvEJrSr/NIme+fqFjmz2
	 Si4qp/omo7gnA==
Message-ID: <124bc6a4-05ee-4682-a0f8-148896eb3c95@kernel.org>
Date: Wed, 7 Jan 2026 09:28:47 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/T2H and RZ/N2H SoCs
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260102-petite-gentle-wasp-81bbb8@quoll>
 <CA+V-a8sryz1f_woi_r8jx_4x7TczrWPyjZoo+P9p=tG8KyK8YA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <CA+V-a8sryz1f_woi_r8jx_4x7TczrWPyjZoo+P9p=tG8KyK8YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/01/2026 18:26, Lad, Prabhakar wrote:
> Hi Krzysztof,
> 
> Thank you for the review.
> 
> On Fri, Jan 2, 2026 at 11:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Tue, Dec 30, 2025 at 11:58:13AM +0000, Prabhakar wrote:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> Document the CAN-FD controller used on the RZ/T2H and RZ/N2H SoCs. The
>>> CAN-FD IP is largely compatible with the R-Car Gen4 block, but differs
>>> in that AFLPN and CFTML are different, there is no reset line for the IP,
>>> and it only supports two channels.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>> v1->v2:
>>> - No changes made.
>>> ---
>>>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 26 ++++++++++++++++++-
>>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>> index fb709cfd26d7..4a83e9e34d67 100644
>>> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
>>> @@ -50,6 +50,12 @@ properties:
>>>                - renesas,r9a09g057-canfd     # RZ/V2H(P)
>>>            - const: renesas,r9a09g047-canfd
>>>
>>> +      - const: renesas,r9a09g077-canfd      # RZ/T2H
>>
>>
>> That's part of other enum with single compatibles.
>>
> There is no enum with single compatibles as of in next [0], there is
> only one compatible `renesas,r9a09g047-canfd`. I can club this with
> RZ/T2H one.

This is the one which is supposed to be enum.

> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml?h=next-20260106
> 
>>> +
>>> +      - items:
>>> +          - const: renesas,r9a09g087-canfd  # RZ/N2H
>>> +          - const: renesas,r9a09g077-canfd
>>> +
>>>    reg:
>>>      maxItems: 1
>>>
>>> @@ -179,7 +185,6 @@ required:
>>>    - clocks
>>>    - clock-names
>>>    - power-domains
>>> -  - resets
>>>    - assigned-clocks
>>>    - assigned-clock-rates
>>>    - channel0
>>> @@ -243,11 +248,30 @@ allOf:
>>>            minItems: 2
>>>            maxItems: 2
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: renesas,r9a09g077-canfd
>>> +    then:
>>> +      properties:
>>> +        interrupts:
>>> +          maxItems: 8
>>> +
>>> +        interrupt-names:
>>> +          maxItems: 8
>>> +
>>> +        resets: false
>>> +    else:
>>> +      required:
>>> +        - resets
>>
>> Why is this de-synced with reset-names? Properties are supposed to
>> behave the same way, not once requiring resets other time requiring
>> reset-names.
>>
> There are SoCs that have a single reset and others that require two
> resets. For SoCs that require two resets, the reset-names property is
> marked as required, while for SoCs with a single reset it is not.

Sure, but I asked why? We expect (and it is documented already in the
docs) that xxx-names always follows xxx, so I really do not understand
why reset-names are valid but resets are not.

> Apart from the RZ/T2H SoC, all SoCs have either one or two resets.
> This difference is why the properties became de-synced. Let me know if
> this can be handled differently.
> 



Best regards,
Krzysztof


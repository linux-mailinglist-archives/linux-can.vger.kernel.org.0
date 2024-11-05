Return-Path: <linux-can+bounces-1904-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE669BCE92
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 15:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA461C21ED6
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB81D86C4;
	Tue,  5 Nov 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8evfFeV"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1981D79A9;
	Tue,  5 Nov 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815414; cv=none; b=GsfuN7cNH27hsoVrf1DsvesY33PLDtm5IctJ812zTrutug9YKE8cgaLl74Gmpg3v9YM3cvzqXT4pwDXbP+fIErRgfskQKbNW9GRj8BIoHwN+YWpm1aLTs1++pbGFtOuyGNsH/PmWqhbSqLFHRdepRbrO604EYKAUgKi0ZxLfcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815414; c=relaxed/simple;
	bh=qWzTJ52uZtUICfzhETc9emz/gMS6nLkohw54WfWP9Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Feu9uSlauf5KFgj3Phff2JqgKorwpr9Vf8FEFB/0RB8CagYNJZliORtJtcQdNvr7bLa8wzMvpdoMnehnMAwYnm32h6YS8HH8kgMFQk1ioe+AQxG3V7/sLmipbTG0ewYAbXNJZcLWCVtZm+sgCJ1KXZvXuzB/KtUddyoF6yE3+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8evfFeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0807C4CECF;
	Tue,  5 Nov 2024 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730815414;
	bh=qWzTJ52uZtUICfzhETc9emz/gMS6nLkohw54WfWP9Sc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t8evfFeVPfzkc7HMna1FB/JOitNRD10vu2cBr8FaxIKBss1Z675DjU6e8lFDmZsBL
	 J+t7gDGB98LdBQTpj0igogI4M4d9AXul6fkDxmAbYJVjE681PJX5ppuKjtySpcFke4
	 z2Bu6jAkdrXSWXqW7EN4RtTOTfURz8i9hKkHVc0fpl7mNluS2exYngvXSoaosXaGz8
	 A5gwCqWV6DKwkfBJVY+s/61N9/DM4CvYWrZE8dQJ7ZIl/3ueAWTXDSeKrlD+7I9xvS
	 ad9hPucfXOt+QVTMerVu+iAPedHaGi8wetp724UCKa0EIdEISe5hOvT+vWbdvFZ+cA
	 4Vx3HDaw6rO+A==
Message-ID: <afb3ebac-4099-42f3-b323-dd6a1555db7a@kernel.org>
Date: Tue, 5 Nov 2024 15:03:27 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
To: Sean Nyekjaer <sean@geanix.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241104125342.1691516-1-sean@geanix.com>
 <dq36jlwfm7hz7dstrp3bkwd6r6jzcxqo57enta3n2kibu3e7jw@krwn5nsu6a4d>
 <wdn2rtfahf3iu6rsgxm6ctfgft7bawtp6vzhgn7dffd54i72lu@r4v5lizhae57>
 <60901c39-b649-4a20-a06a-7faa7ddc9346@kernel.org>
 <mtuev7pve5ltr6vvknp2bwtwg2m7mzxduzshzbr7y3i7mwbzy6@qjbdjyb56nrv>
 <f5a28e36-ef80-4ccf-b615-03fb10eb661e@kernel.org>
 <g2knbmyi7cy4xnkospby7xtp6t4f2ppfdbtdyjteltrlnaihcp@gdjhp4n5w7u3>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <g2knbmyi7cy4xnkospby7xtp6t4f2ppfdbtdyjteltrlnaihcp@gdjhp4n5w7u3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2024 13:59, Sean Nyekjaer wrote:
> On Tue, Nov 05, 2024 at 01:41:26PM +0100, Krzysztof Kozlowski wrote:
> 
> NOW I get it :)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> index f1d18a5461e0..4fb5e5e80a03 100644
> --- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> @@ -169,7 +169,7 @@ examples:
>          #size-cells = <0>;
> 
>          can@0 {
> -            compatible = "ti,tcan4552", "ti,tcan4x5x";
> +            compatible = "ti,tcan4552";
>              reg = <0>;
>              clocks = <&can0_osc>;
>              pinctrl-names = "default";
> 
> Would result in a schema check fail, but the driver will never be probed.
> 
>>

Yeah, but we dont' talk about this case.


>>> Agree that is kinda broken.
>>> If I have time I can try to fix that later.
>>
>> No, the fix is to drop the wildcard alone, as I said in your RFC.
> 
> @Mark, would you be okay with fixing the wildcard in this series?
> We have some out-of-tree dtb's that will need fixing, but I get it would be
> prefered to get this fixed.

Out of tree DTB will not need any fixes per-se. They will work 100%
fine. They will however report dtbs_check warnings, but before there was
no DT schema validation for them, so you replace one warning into
another warning.

You can of course improve out of tree users by dropping all warnings,
but that's kind of optional. The point is that nothing gets worse.

> 
>>
>>>
>>> Please explain one more time for me. Is this a comment on the if
>>> sentence or the broken behavior of the driver?
>>
>> This is just generic comment, nothing to change here because you decided
>> not to fix that wildcard from old binding.
> 
> Thanks for the clarification!
> 
> @Mark, @Krzysztof: What to do from here?

I will give Rb tag for next version fixing commented issues regardless
whether you drop usage of the wildcard-like 4x5x compatible alone. IOW,
I will be fine with pure conversion and keeping 4x5x, even though I
would prefer to improve the binding based on arguments before: there
will be no changes needed for in-kernel users, no out-of-tree users will
be affected, no breakage and using wildcard compatible alone is
discouraged. Sometimes strongly discouraged, depending on the case.

Best regards,
Krzysztof



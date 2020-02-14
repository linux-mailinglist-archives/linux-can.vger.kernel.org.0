Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45915D8DF
	for <lists+linux-can@lfdr.de>; Fri, 14 Feb 2020 14:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgBNN7p (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Feb 2020 08:59:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48561 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgBNN7p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Feb 2020 08:59:45 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1j2bVQ-0003vV-Gg; Fri, 14 Feb 2020 14:59:44 +0100
Received: from [IPv6:2a03:f580:87bc:d400:e02c:7418:d735:94c1] (unknown [IPv6:2a03:f580:87bc:d400:e02c:7418:d735:94c1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 68CBA4B7AC4;
        Fri, 14 Feb 2020 13:59:43 +0000 (UTC)
Subject: Re: mcp25xxfd: missing cerrif
To:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org
References: <a933c5be-c95f-36d5-57ce-c312fbaa81db@pengutronix.de>
 <MN2PR11MB36450B9C2BE91F6CBA897002FB180@MN2PR11MB3645.namprd11.prod.outlook.com>
 <532b4fed-a984-0875-d933-43c6a90fcc1a@pengutronix.de>
 <MN2PR11MB36458E1696285A0196B6E46FFB1B0@MN2PR11MB3645.namprd11.prod.outlook.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 mQINBFFVq30BEACtnSvtXHoeHJxG6nRULcvlkW6RuNwHKmrqoksispp43X8+nwqIFYgb8UaX
 zu8T6kZP2wEIpM9RjEL3jdBjZNCsjSS6x1qzpc2+2ivjdiJsqeaagIgvy2JWy7vUa4/PyGfx
 QyUeXOxdj59DvLwAx8I6hOgeHx2X/ntKAMUxwawYfPZpP3gwTNKc27dJWSomOLgp+gbmOmgc
 6U5KwhAxPTEb3CsT5RicsC+uQQFumdl5I6XS+pbeXZndXwnj5t84M+HEj7RN6bUfV2WZO/AB
 Xt5+qFkC/AVUcj/dcHvZwQJlGeZxoi4veCoOT2MYqfR0ax1MmN+LVRvKm29oSyD4Ts/97cbs
 XsZDRxnEG3z/7Winiv0ZanclA7v7CQwrzsbpCv+oj+zokGuKasofzKdpywkjAfSE1zTyF+8K
 nxBAmzwEqeQ3iKqBc3AcCseqSPX53mPqmwvNVS2GqBpnOfY7Mxr1AEmxdEcRYbhG6Xdn+ACq
 Dq0Db3A++3PhMSaOu125uIAIwMXRJIzCXYSqXo8NIeo9tobk0C/9w3fUfMTrBDtSviLHqlp8
 eQEP8+TDSmRP/CwmFHv36jd+XGmBHzW5I7qw0OORRwNFYBeEuiOIgxAfjjbLGHh9SRwEqXAL
 kw+WVTwh0MN1k7I9/CDVlGvc3yIKS0sA+wudYiselXzgLuP5cQARAQABtCZNYXJjIEtsZWlu
 ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPokCVAQTAQoAPgIbAwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUsSbBQkM366zAAoJECte4hHF
 iupUgkAP/2RdxKPZ3GMqag33jKwKAbn/fRqAFWqUH9TCsRH3h6+/uEPnZdzhkL4a9p/6OeJn
 Z6NXqgsyRAOTZsSFcwlfxLNHVxBWm8pMwrBecdt4lzrjSt/3ws2GqxPsmza1Gs61lEdYvLST
 Ix2vPbB4FAfE0kizKAjRZzlwOyuHOr2ilujDsKTpFtd8lV1nBNNn6HBIBR5ShvJnwyUdzuby
 tOsSt7qJEvF1x3y49bHCy3uy+MmYuoEyG6zo9udUzhVsKe3hHYC2kfB16ZOBjFC3lH2U5An+
 yQYIIPZrSWXUeKjeMaKGvbg6W9Oi4XEtrwpzUGhbewxCZZCIrzAH2hz0dUhacxB201Y/faY6
 BdTS75SPs+zjTYo8yE9Y9eG7x/lB60nQjJiZVNvZ88QDfVuLl/heuIq+fyNajBbqbtBT5CWf
 mOP4Dh4xjm3Vwlz8imWW/drEVJZJrPYqv0HdPbY8jVMpqoe5jDloyVn3prfLdXSbKPexlJaW
 5tnPd4lj8rqOFShRnLFCibpeHWIumqrIqIkiRA9kFW3XMgtU6JkIrQzhJb6Tc6mZg2wuYW0d
 Wo2qvdziMgPkMFiWJpsxM9xPk9BBVwR+uojNq5LzdCsXQ2seG0dhaOTaaIDWVS8U/V8Nqjrl
 6bGG2quo5YzJuXKjtKjZ4R6k762pHJ3tnzI/jnlc1sXz
Message-ID: <a049ea8b-a3e2-ea39-d084-bd12b637cb9c@pengutronix.de>
Date:   Fri, 14 Feb 2020 14:59:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB36458E1696285A0196B6E46FFB1B0@MN2PR11MB3645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2/12/20 10:59 AM, Thomas.Kopp@microchip.com wrote:
>> On the transition from "TX ERROR_WARNING -> TX ERROR_ACTIVE" the 
>> CERRIF is not set.
> Mhm, do I misunderstand your point here?

I misread the documentation somehow.

Hmmm. I think the question is, is there a dedicated warning state and
if, how are the transitions from and to it?

From my understanding:

           -- E > 95 --     -- E > 127 --     -- E > 255 --
          /            \   /             \   /             \
         /              V /               V /               V
--> error active  error warning      error passive       bus off
         ^              / ^               /
          \            /   \             /
           -- E < 96 --     -- E < 128 --

> The Transition TX ERROR_WARNING -> TX ERROR_ACTIVE isn't covered by
> the CERRIF interrupt (which matches the documentation).

ACK. The documentation talks about error passive to error active, which
means the diagram looks like this:

           -- E > 95 --     -- E > 127 --     -- E > 255 --
          /            \   /             \   /             \
         /              V /               V /               V
--> error active  error warning      error passive       bus off
         ^                                /
          \                              /
           ------------------- E < 128 --

> The interrupt bit gets set on ERROR_Passive to ERROR_ACTIVE (TEC/REC
> goes from 128 to 127).

I think we have to discuss how the state diagram on socketcan should
look like.

> At that transition I do see the CERRIF bit. It is correct and
> intended (though maybe not 100% intuitive) that going from
> ERROR_WARNING to ERROR_ACTIVE TEC/REC 96 to 95 CERRIF is NOT being
> set.

Ok.

regards
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

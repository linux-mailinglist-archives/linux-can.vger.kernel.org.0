Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98291718DC
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2019 15:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfGWNCd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Jul 2019 09:02:33 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:8751 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387961AbfGWNCc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jul 2019 09:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563886948;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ST8GSgIkJcFG/Zd6nPUJ+wRCQN1ShzXL+U/dHYzDLgo=;
        b=SM55T1M8sInEDfBLvaezZvqpaNpwWDe5vUe5YcxgqvUzbxsEeMIzku4U4mpPB1+K3P
        4BuMZ7bTWa2oXLpmeNow60L6SYu5XcGyLghZVFIAZmVfx5z5DYneroyEGaCG5zHTye5b
        deOzGBQkATNLssoKagPJgB7lcCr2y+4YwVadF0GKPCTJS5Bk53zow0skIPHIM/UPWiGX
        n4mWaGGmz38ullHEn47YAGVBDDg5dFEilEmp6DmnWuW5EcstTk9HyPOKr9f2oXfLcxhr
        2ATFIBBTmK4LryjI3dL2O4apOjlQxHiypXL3ci/6mZIhSAcYLDxKO175shL078N5mKWq
        MM8g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJV8h6liA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.202]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6ND2ReF7
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 23 Jul 2019 15:02:27 +0200 (CEST)
Subject: Re: [PATCH] can: Add SPDX license identifiers for CAN subsystem
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20190723124411.17353-1-socketcan@hartkopp.net>
 <df70ebc2-10ab-710f-6b64-f414cf02ca80@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <c2efcd72-0e95-9024-cc82-d6974181eafd@hartkopp.net>
Date:   Tue, 23 Jul 2019 15:02:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <df70ebc2-10ab-710f-6b64-f414cf02ca80@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 23.07.19 14:57, Marc Kleine-Budde wrote:
> On 7/23/19 2:44 PM, Oliver Hartkopp wrote:
>> Add missing SPDX identifiers for the CAN network layer and correct the SPDX
>> license for two of its include files to make sure the BSD-3-Clause applies
>> for the entire subsystem.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> checkpatch complains (I'm not sure why it sees DOS line endings, though):

Oops - I'm not working under DOS ;-)

Maybe the in-kernel file I copied the line from had a problem.

Will send an update ...

Tnx,
Oliver

> 
> ERROR: DOS line endings
> #96: FILE: include/linux/can/core.h:1:
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */^M$
> 
> ERROR: DOS line endings
> #106: FILE: include/linux/can/skb.h:1:
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */^M$
> 
> ERROR: DOS line endings
> #115: FILE: net/can/af_can.c:1:
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */^M$
> 
> WARNING: Improper SPDX comment style for 'net/can/af_can.c', please use '//' instead
> #115: FILE: net/can/af_can.c:1:
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> 
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #115: FILE: net/can/af_can.c:1:
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> 
> 
> ERROR: DOS line endings
> #124: FILE: net/can/af_can.h:1:
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */^M$
> 
> ERROR: DOS line endings
> #133: FILE: net/can/bcm.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */^M$
> 
> WARNING: Improper SPDX comment style for 'net/can/bcm.c', please use '//' instead
> #133: FILE: net/can/bcm.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #133: FILE: net/can/bcm.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> WARNING: line over 80 characters
> #133: FILE: net/can/bcm.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> ERROR: DOS line endings
> #142: FILE: net/can/gw.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */^M$
> 
> WARNING: Improper SPDX comment style for 'net/can/gw.c', please use '//' instead
> #142: FILE: net/can/gw.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #142: FILE: net/can/gw.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> WARNING: line over 80 characters
> #142: FILE: net/can/gw.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> ERROR: DOS line endings
> #151: FILE: net/can/proc.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */^M$
> 
> WARNING: Improper SPDX comment style for 'net/can/proc.c', please use '//' instead
> #151: FILE: net/can/proc.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #151: FILE: net/can/proc.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> WARNING: line over 80 characters
> #151: FILE: net/can/proc.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> ERROR: DOS line endings
> #160: FILE: net/can/raw.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */^M$
> 
> WARNING: Improper SPDX comment style for 'net/can/raw.c', please use '//' instead
> #160: FILE: net/can/raw.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #160: FILE: net/can/raw.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> WARNING: line over 80 characters
> #160: FILE: net/can/raw.c:1:
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> 
> 
> total: 8 errors, 14 warnings, 0 checks, 34 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>        mechanically convert to the typical style using --fix or --fix-inplace.
> 
> /home/frogger/Downloads/mail/j1939/[PATCH] can: Add SPDX license identifiers for CAN subsystem.eml has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>        them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> Marc
> 

Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87CF2EEDB6
	for <lists+linux-can@lfdr.de>; Fri,  8 Jan 2021 08:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbhAHHJP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jan 2021 02:09:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:50596 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbhAHHJP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 8 Jan 2021 02:09:15 -0500
IronPort-SDR: qycPocURuxnfo8auNKp8TJHv+v/c4jy9NvcJ5XQHcuAgm9TdrhVk5qchYSw/Tp3tNC4V7F9+Dw
 Qh51B3aENAgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="262325099"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="262325099"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 23:08:34 -0800
IronPort-SDR: V+v18GIAcnns8HSWKb4IcZLnMvyVgfLH1VA42fE8jts4LEnchua5TioeyRVWGT6gH1zRgiVbRs
 pMpaniKSEfyA==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="380025907"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 23:08:33 -0800
Subject: Re: [kbuild-all] Re: [net-next 19/19] can: flexcan: add CAN wakeup
 function for i.MX8QM
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-can <linux-can@vger.kernel.org>
References: <20210107094900.173046-20-mkl@pengutronix.de>
 <202101080428.hEujUZlS-lkp@intel.com>
 <13f12660-cb33-d610-a933-1e3459791159@pengutronix.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <42ec4ab0-b544-e7d7-d5e9-7609cb2273d3@intel.com>
Date:   Fri, 8 Jan 2021 15:07:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <13f12660-cb33-d610-a933-1e3459791159@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 1/8/21 5:22 AM, Marc Kleine-Budde wrote:
> On 1/7/21 9:07 PM, kernel test robot wrote:
>> Hi Marc,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on net-next/master]
>>
>> url:    https://github.com/0day-ci/linux/commits/Marc-Kleine-Budde/can-tcan4x5x-replace-DEVICE_NAME-by-KBUILD_MODNAME/20210107-184956
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 3db1a3fa98808aa90f95ec3e0fa2fc7abf28f5c9
>> config: m68k-allmodconfig (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/0day-ci/linux/commit/90434a61388963ddee49d0c805226dd4b56df274
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Marc-Kleine-Budde/can-tcan4x5x-replace-DEVICE_NAME-by-KBUILD_MODNAME/20210107-184956
>>          git checkout 90434a61388963ddee49d0c805226dd4b56df274
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> ERROR: modpost: "imx_scu_get_handle" [drivers/net/can/flexcan.ko] undefined!
> Another false positive, due to the old net-next/master base.
>
> Marc
>

Hi Marc,

Sorry for the inconvenience, we'll take a look at this problem.

Best Regards,
Rong Chen
